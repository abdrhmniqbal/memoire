String getHost(String url) {
  return Uri.parse(url).host;
}

String validateUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return 'http://$url';

  if (uri.scheme.isEmpty) {
    return 'http://$url';
  }

  return url;
}
