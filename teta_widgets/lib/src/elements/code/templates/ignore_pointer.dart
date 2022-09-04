// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for IgnorePointer widget
Future<String> ignorePointerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) async {
  final flag = body.attributes[DBKeys.flag] as bool;

  if (!flag) {
    return CS.child(
      context,
      child,
      comma: false,
      withChild: false,
    );
  }

  final childString = await CS.child(context, child, comma: true);
  final code = '''
    IgnorePointer(
      ignoring: $flag,
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
