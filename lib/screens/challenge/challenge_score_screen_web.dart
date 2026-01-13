import 'dart:html' as html;
import 'dart:typed_data';

/// Web-specific implementation for downloading images
void downloadImage(Uint8List imageBytes, String filename) {
  final blob = html.Blob([imageBytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', filename)
    ..click();
  html.Url.revokeObjectUrl(url);
}

