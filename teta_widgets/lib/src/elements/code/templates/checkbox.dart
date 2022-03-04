// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String checkBoxCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  CNode? child,
  int? loop,
) {
  final flag = body.attributes[DBKeys.flag] as bool;
  return '''
    Checkbox(
      value: $flag,
      ${CS.action(context, node, ActionGesture.onChange, 'onChanged: (bool? value) async ', null, isRequired: false)}
    )
  ''';
}
