// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// ClipOval Template
Future<String> clipOvalCodeTemplate(
  final BuildContext context,
  final CNode node,
  final CNode? child,
) async {
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    ClipOval(
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return '''
    const SizedBox()
    ''';
  }
}
