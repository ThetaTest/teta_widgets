// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino Switch Template
String cupertinoSwitchCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  CNode? child,
) {
  return '''
    CupertinoSwitch(
      ${CS.action(context, node, ActionGesture.onTap, 'onPressed: () async', null, isRequired: true)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
