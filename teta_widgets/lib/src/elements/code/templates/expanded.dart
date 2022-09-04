// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Expanded widget
Future<String> expandedCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) async {
  /*final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final flex = int.tryParse(value) != null ? int.parse(value) : '1';*/
  //final flexString = CS.avoidRedundantValue(flex, 'flex', '1');
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    Expanded(
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
