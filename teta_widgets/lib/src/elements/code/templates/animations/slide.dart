// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for SlideAnimation widget
class SlideCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    SlideAnimation(
      $childString
    )
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
