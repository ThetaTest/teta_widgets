// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Google Login Template
String loginGoogleCodeTemplate(
  final BuildContext context,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  return '''
  GoogleAuthButton(
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
