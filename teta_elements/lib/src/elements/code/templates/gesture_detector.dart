// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_core/src/elements/nodes/node.dart';

/// GestureDetector Template
String gestureDetectorCodeTemplate(
  BuildContext context,
  CNode node,
  CNode? child,
) {
  return '''
  GestureDetector(
    ${CS.action(context, node, ActionGesture.onTap, 'onTap: () async', null, isRequired: false)}
    ${CS.action(context, node, ActionGesture.onDoubleTap, 'onDoubleTap: () async', null, isRequired: false)}
    ${CS.action(context, node, ActionGesture.onLongPress, 'onLongPress: () async', null, isRequired: false)}
    ${CS.child(context, child, comma: true)}
  )
  ''';
}
