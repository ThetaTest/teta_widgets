// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Container Template
class DotsIndicatorCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        ${CS.margin(context, body, isMargin: true)}
        ${CS.margin(context, body, isMargin: false)}
        ${CS.size(context, body, isWidth: true)}
        ${CS.size(context, body, isWidth: false)}
        ${CS.boxDecoration(context, body, DBKeys.fill)}
        $childString
      ),
    ],
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
