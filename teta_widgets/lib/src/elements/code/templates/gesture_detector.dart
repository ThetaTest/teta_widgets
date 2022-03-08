// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// GestureDetector Template
String gestureDetectorCodeTemplate(
  final BuildContext context,
  final CNode node,
  final CNode? child,
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
