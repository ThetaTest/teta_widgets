// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino Switch Template
String cupertinoSwitchCodeTemplate(
  final int pageId,
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  return '''
    CupertinoSwitch(
      value: false,
      ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onChange,
    'onChanged: (value) async',
    'false',
    isRequired: true,
    loop: loop,
  )}
    )
  ''';
}
