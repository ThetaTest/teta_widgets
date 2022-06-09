// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Apple Login Template
String loginAppleCodeTemplate(
  final int pageId,
  final BuildContext context,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  return '''
SizedBox(
    ${CS.size(context, node.body, isWidth: true)}
    ${CS.size(context, node.body, isWidth: false)}
    child: AppleAuthButton(
      ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onTap,
    'onPressed: () async',
    null,
    isRequired: true,
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
    ),
  )
  ''';
}
