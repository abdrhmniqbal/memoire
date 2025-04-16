import 'package:dio/dio.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';

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
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.39 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      },
    ),
  );

  static Future<Metadata> fetchMetadata(String url) async {
    try {
      final baseUri = Uri.parse(url);
      final response = await _dio.getUri(baseUri);

      if (response.statusCode == 200 && response.data is String) {
        final body = response.data as String;

        if (body.contains('cf-browser-verification') ||
            body.contains('Checking if the site connection is secure')) {
          // Optional retry (though usually won't bypass Cloudflare)
          return Metadata(error: 'Blocked by Cloudflare protection');
        }

        final soup = BeautifulSoup(body);
        return _parseMetadata(soup, baseUri);
      }

      return Metadata(error: 'Failed with status ${response.statusCode}');
    } on DioException catch (e) {
      return Metadata(error: 'Dio error: ${e.message}');
    } catch (e) {
      return Metadata(error: e.toString());
    }
  }

  static Metadata _parseMetadata(BeautifulSoup soup, Uri baseUri) {
    String? getMetaContent(String property) {
      return soup
              .find('meta', attrs: {'property': property})
              ?.attributes['content'] ??
          soup.find('meta', attrs: {'name': property})?.attributes['content'];
    }

    String? getFirstImage() => soup.find('img')?.attributes['src'];

    String? getFavicon() {
      return soup.find('link', attrs: {'rel': 'icon'})?.attributes['href'] ??
          soup
              .find('link', attrs: {'rel': 'shortcut icon'})
              ?.attributes['href'];
    }

    String? title = getMetaContent('og:title') ?? soup.title?.text;
    String? description =
        getMetaContent('og:description') ?? getMetaContent('description');
    String? tags = getMetaContent('keywords');
    String? favicon = getFavicon();
    if (favicon != null) favicon = baseUri.resolve(favicon).toString();
    String? image =
        getMetaContent('og:image') ?? getMetaContent('twitter:image');
    image ??= getFirstImage();
    if (image != null) image = baseUri.resolve(image).toString();

    return Metadata(
      title: title,
      description: description,
      tags: tags,
      favicon: favicon,
      image: image,
    );
  }
}
