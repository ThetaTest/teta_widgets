// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// GestureDetector Template
String gestureDetectorCodeTemplate(
  final int pageId,
  final BuildContext context,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  return '''
  GestureDetector(
    ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onTap,
    'onTap: () async',
    null,
    isRequired: false,
    loop: loop,
  )}
    ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onDoubleTap,
    'onDoubleTap: () async',
    null,
    isRequired: false,
    loop: loop,
  )}
    ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onLongPress,
    'onLongPress: () async',
    null,
    isRequired: false,
    loop: loop,
  )}
    ${CS.child(context, child, comma: true)}
  )
  ''';
}
