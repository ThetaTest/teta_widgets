import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for WebViewX widget
class WebViewXTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
  ) async {
    final abstract = body.attributes[DBKeys.valueOfCondition] as FTextTypeInput;
    final value = abstract.toCode(
      0,
      resultType: ResultTypeEnum.string,
    );
    final code = '''
    LayoutBuilder(builder: (context, constraints) {
      return WebViewX(
        initialContent: $value,
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
      final defaultCode = await toCode(
        context,
        NodeBody.get(NType.webview),
      );
      return defaultCode;
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'WebView';
    final nodeBody = NodeBody.get(NType.webview);
    final codeToRun = await toCode(
      context,
      nodeBody,
    );
    final returnValue = FormatterTest.format(
      codeToRun,
    );
    if (!returnValue) {
      Logger.printError(
        'Runtime ToCode Default Error:\n$name\nThis was the code:\n',
      );
      Logger.printWarning(codeToRun);
      Logger.printMessage('\n-----------END-----------');
    } else {
      Logger.printSuccess('$name: Passed!');
    }
    return returnValue;
  }

  static void testCode() {
    group('WebViewX toCode test', () {
      test(
        'WebViewX: default code',
        () {
          final body = NodeBody.get(NType.webview);
          body.attributes[DBKeys.valueOfCondition] = FTextTypeInput(
            value: 'https://teta.so',
          );
          final abstract =
              body.attributes[DBKeys.valueOfCondition] as FTextTypeInput;
          final defaultValue = abstract.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
            LayoutBuilder(builder: (context, constraints) {
      return WebViewX(
        initialContent: $defaultValue,
        initialSourceType: SourceType.url,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        );
       })'''),
            true,
          );
        },
      );
    });
  }
}
