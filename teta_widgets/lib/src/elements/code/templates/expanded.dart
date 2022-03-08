// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Expanded widget
String expandedCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  /*final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final flex = int.tryParse(value) != null ? int.parse(value) : '1';*/
  //final flexString = CS.avoidRedundantValue(flex, 'flex', '1');
  return '''
    Expanded(
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
