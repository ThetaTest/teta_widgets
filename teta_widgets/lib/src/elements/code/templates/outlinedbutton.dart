// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// OutlinedButton Template
String outlinedButtonCodeTemplate(
  BuildContext context,
  CNode node,
  CNode? child,
) {
  return '''
    OutlinedButton(
      ${CS.action(context, node, ActionGesture.onTap, 'onPressed: () async', null, isRequired: true)}
      ${CS.action(context, node, ActionGesture.onLongPress, 'onLongPress: () async', null, isRequired: false)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}