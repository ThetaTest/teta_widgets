// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Apple Login Template
String loginAppleCodeTemplate(
  final BuildContext context,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  return '''
    AppleAuthButton(
      ${CS.action(
    context,
    node,
    ActionGesture.onTap,
    'onPressed: () async',
    null,
    isRequired: true,
    loop: loop,
  )}
      ${CS.action(
    context,
    node,
    ActionGesture.onLongPress,
    'onLongPress: () async',
    null,
    isRequired: false,
    loop: loop,
  )}
    )
  ''';
}
