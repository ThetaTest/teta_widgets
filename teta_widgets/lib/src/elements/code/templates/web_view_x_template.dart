import 'package:teta_widgets/src/elements/code/formatter_test.dart';

/// Generates the code for WebViewX widget
class WebViewXTemplate {
  static Future<String> toCode({required final String initialUrl}) async {
    final code = '''
    LayoutBuilder(builder: (context, constraints) {
      return WebViewX(
        initialContent: $initialUrl,
        initialSourceType: SourceType.url,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );
    })
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode(){}
}
