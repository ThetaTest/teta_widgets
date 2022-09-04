// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Container Template
Future<String> containerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) async {
  var margin = CS.margin(context, body, isMargin: true);
  if (margin == 'margin: EdgeInsets.zero,') margin = '';
  var padding = CS.margin(context, body, isMargin: false);
  if (padding == 'padding: EdgeInsets.zero,') padding = '';
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    Container(
      $margin
      $padding
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.boxDecoration(context, body, DBKeys.fill)}
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    final code = await containerCodeTemplate(
      context,
      NodeBody.get(NType.container),
      child,
    );
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return containerCodeTemplate(
        context,
        NodeBody.get(NType.container),
        null,
      );
    }
  }
}
