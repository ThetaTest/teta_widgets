// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Center widget
Future<String> centerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) async {
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    Center(
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return centerCodeTemplate(context, body, null);
  }
}
