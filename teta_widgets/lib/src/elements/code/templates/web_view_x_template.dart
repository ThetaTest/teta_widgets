// Flutter imports:
// Project imports:

class WebViewXTemplate {
  static String toCode({required final String initialUrl}) {
    return '''
LayoutBuilder(builder: (context, constraints) {
      return WebViewX(
        initialContent: $initialUrl,
        initialSourceType: SourceType.url,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );
    })
  ''';
  }
}
