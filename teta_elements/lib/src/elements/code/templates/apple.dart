// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_core/src/elements/nodes/node.dart';

/// Apple Login Template
String loginAppleCodeTemplate(BuildContext context, CNode node, CNode? child) {
  return '''
    AppleAuthButton(
      ${CS.action(context, node, ActionGesture.onTap, 'onPressed: () async', null, isRequired: true)}
      ${CS.action(context, node, ActionGesture.onLongPress, 'onLongPress: () async', null, isRequired: false)}
    )
  ''';
}
