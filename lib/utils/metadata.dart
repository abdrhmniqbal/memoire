import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class Metadata {
  final String? title;
  final String? description;
  final String? tags;
  final String? favicon;
  final String? image;
  final String? error;

  Metadata({
    this.title,
    this.description,
    this.tags,
    this.favicon,
    this.image,
    this.error,
  });

  bool get hasError => error != null;
}

class MetadataFetcher {
  static final cookieJar = CookieJar();
  static final Dio _dio =
      Dio()
        ..options = BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.39 Safari/537.36',
            'Accept':
                'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          },
        )
        ..interceptors.add(CookieManager(cookieJar));

  static Future<Metadata> fetchMetadata(String url) async {
    try {
      final baseUri = Uri.parse(url);
      final response = await _dio.getUri(baseUri);

      if (isCloudflareChallenge(response)) {
        await solveCloudflareChallenge(response, baseUri);
        // Retry the original request with updated cookies
        final retryResponse = await _dio.getUri(baseUri);
        if (retryResponse.statusCode == 200 && retryResponse.data is String) {
          final body = retryResponse.data as String;
          final soup = BeautifulSoup(body);
          return _parseMetadata(soup, baseUri);
        } else {
          return Metadata(error: 'Failed to fetch after solving challenge');
        }
      } else if (response.statusCode == 200 && response.data is String) {
        final body = response.data as String;
        final soup = BeautifulSoup(body);
        return _parseMetadata(soup, baseUri);
      } else {
        return Metadata(error: 'Failed with status ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Metadata(error: 'Dio error: ${e.message}');
    } catch (e) {
      return Metadata(error: e.toString());
    }
  }

  static bool isCloudflareChallenge(Response response) {
    final data = response.data.toString();
    final serverHeaders = response.headers['server'];
    final serverIsCloudflare =
        serverHeaders?.any(
          (header) => header.toLowerCase().startsWith('cloudflare'),
        ) ??
        false;
    return (response.statusCode == 503 || response.statusCode == 429) &&
        serverIsCloudflare &&
        (data.contains('jschl_vc') && data.contains('jschl_answer') ||
            data.contains('cf-browser-verification') ||
            data.contains('Checking if the site connection is secure'));
  }

  static Future<void> solveCloudflareChallenge(
    Response challengeResponse,
    Uri baseUri,
  ) async {
    final soup = BeautifulSoup(challengeResponse.data as String);
    final challengeForm = soup.find('form', id: 'challenge-form');
    if (challengeForm == null) {
      throw Exception('Challenge form not found');
    }

    final action = challengeForm.attributes['action'];
    if (action == null) {
      throw Exception('Action not found in challenge form');
    }
    final submitUrl = baseUri.resolve(action).toString();
    final method = challengeForm.attributes['method']?.toUpperCase() ?? 'GET';

    // Extract form data
    final inputs = challengeForm.findAll('input');
    Map<String, String> formData = {};
    for (var input in inputs) {
      final name = input.attributes['name'];
      final value = input.attributes['value'];
      if (name != null && value != null && name != 'jschl_answer') {
        formData[name] = value;
      }
    }

    // Verify required fields
    for (var key in ['jschl_vc', 'pass']) {
      if (!formData.containsKey(key)) {
        throw Exception('$key is missing from challenge form');
      }
    }

    // Solve the JavaScript challenge
    final startTime = DateTime.now();
    final (answer, delay) = await solveChallenge(soup, baseUri.host);
    final elapsed = DateTime.now().difference(startTime).inMilliseconds / 1000;
    final remainingDelay = delay - elapsed;
    if (remainingDelay > 0) {
      await Future.delayed(
        Duration(milliseconds: (remainingDelay * 1000).toInt()),
      );
    }

    formData['jschl_answer'] = answer;

    // Submit the form with appropriate headers
    final headers = {
      'Referer': challengeResponse.requestOptions.uri.toString(),
    };
    if (method == 'POST') {
      await _dio.post(
        submitUrl,
        data: formData,
        options: Options(headers: headers),
      );
    } else {
      final uri = Uri.parse(submitUrl).replace(queryParameters: formData);
      await _dio.getUri(uri, options: Options(headers: headers));
    }
  }

  static Future<(String, double)> solveChallenge(
    BeautifulSoup soup,
    String domain,
  ) async {
    // Find the challenge script
    final scripts = soup.findAll('script', attrs: {'type': 'text/javascript'});
    final challengeScript = scripts.firstWhere(
      (script) => script.text.contains('jschl-answer'),
      orElse: () => throw Exception('Challenge script not found'),
    );

    // Extract challenge code and delay
    final challengeMatch = RegExp(
      r'setTimeout\(function\(\){\s*(var s,t,o,p,b,r,e,a,k,i,n,g,f.+?\r?\n[\s\S]+?a\.value\s*=.+?)\r?\n(?:[^{<>]*},\s*(\d{4,}))?',
      dotAll: true,
    ).firstMatch(challengeScript.text);
    if (challengeMatch == null) {
      throw Exception('Unable to parse challenge code');
    }
    final challenge = challengeMatch.group(1)!;
    final ms = challengeMatch.group(2);
    final delay = ms != null ? double.parse(ms) / 1000 : 8.0;

    // Extract innerHTML for challenge computation
    String? k;
    for (var line in challengeScript.text.split(';')) {
      if (line.trim().startsWith('k=')) {
        k = line.trim().split('=')[1].trim().replaceAll("'", '');
        break;
      }
    }
    if (k == null) {
      throw Exception('Unable to find k for innerHTML');
    }
    final innerHtmlDiv = soup.find('div', id: k);
    final innerHTML = innerHtmlDiv?.text ?? '';

    // Construct JavaScript code to solve the challenge
    final challengeCode = '''
var document = {
  createElement: function () {
    return { firstChild: { href: "http://$domain/" } };
  },
  getElementById: function () {
    return {"innerHTML": "$innerHTML"};
  }
};
$challenge; a.value
''';

    // Encode and execute with Node.js
    final encodedChallenge = base64Encode(utf8.encode(challengeCode));
    final js = '''
var atob = function (str) {
  return Buffer.from(str, 'base64').toString('binary');
};
var challenge = atob("$encodedChallenge");
var context = {
  atob: atob
};
var options = {
  filename: "iuam-challenge.js",
  timeout: 5000
};
console.log(require('vm').runInNewContext(challenge, context, options));
''';

    final result = await Process.run('node', ['-e', js]);
    if (result.exitCode != 0) {
      throw Exception('Node.js execution failed: ${result.stderr}');
    }
    final answer = (result.stdout as String).trim();
    return (answer, delay);
  }

  static Metadata _parseMetadata(BeautifulSoup soup, Uri baseUri) {
    // Check for <base> tag to determine the effective base URL
    Uri effectiveBaseUri = baseUri;
    final baseTag = soup.find('base');
    if (baseTag != null) {
      final baseHref = baseTag.attributes['href'];
      if (baseHref != null) {
        final parsedBase = Uri.tryParse(baseHref);
        if (parsedBase != null && parsedBase.isAbsolute) {
          effectiveBaseUri = parsedBase; // Use <base> href if it’s absolute
        }
      }
    }

    // Helper function to get meta content by property or name
    String? getMetaContent(String property) {
      return soup
              .find('meta', attrs: {'property': property})
              ?.attributes['content'] ??
          soup.find('meta', attrs: {'name': property})?.attributes['content'];
    }

    // Helper function to get the first image’s src
    String? getFirstImage() => soup.find('img')?.attributes['src'];

    // Helper function to get favicon URL
    String? getFavicon() {
      return soup.find('link', attrs: {'rel': 'icon'})?.attributes['href'] ??
          soup
              .find('link', attrs: {'rel': 'shortcut icon'})
              ?.attributes['href'];
    }

    // Extract metadata fields
    String? title = getMetaContent('og:title') ?? soup.title?.text;
    String? description =
        getMetaContent('og:description') ?? getMetaContent('description');
    String? tags = getMetaContent('keywords');

    // Handle favicon
    String? favicon = getFavicon();
    if (favicon != null) {
      final faviconUri = Uri.tryParse(favicon);
      if (faviconUri != null && !faviconUri.isAbsolute) {
        // Convert relative favicon URL to absolute
        favicon = effectiveBaseUri.resolveUri(faviconUri).toString();
      } else {
        // If absolute (e.g., https:// or data:), keep as is
        favicon = faviconUri?.toString() ?? favicon;
      }
    }

    // Handle image
    String? image =
        getMetaContent('og:image') ?? getMetaContent('twitter:image');
    image ??= getFirstImage();
    if (image != null) {
      final imageUri = Uri.tryParse(image);
      if (imageUri != null && !imageUri.isAbsolute) {
        // Convert relative image URL to absolute
        image = effectiveBaseUri.resolveUri(imageUri).toString();
      } else {
        // If absolute, keep as is
        image = imageUri?.toString() ?? image;
      }
    }

    // Return the metadata object
    return Metadata(
      title: title,
      description: description,
      tags: tags,
      favicon: favicon,
      image: image,
    );
  }
}
