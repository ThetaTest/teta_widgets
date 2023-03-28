// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for App Bar widget
class AppBarCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final childString = await CS.child(context, child, comma: false);
    final code = '''
    ${childString.replaceFirst('child:', '')}
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {}
}
