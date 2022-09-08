// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// SizedBox Template
class SizedBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final width = CS.size(context, body, isWidth: true);
    final height = CS.size(context, body, isWidth: false);
    if (width.isEmpty && height.isEmpty) {
      return CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
    }
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    SizedBox(
      $width
      $height
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
