// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino Picker Template
String cupertinoPickerCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  CNode? child,
) {
  final flag = body.attributes[DBKeys.flag] as bool;
  final itemExtent = CS
      .size(context, body, isWidth: false)
      .replaceFirst('height:', 'itemExtent:');
  return '''
    CupertinoPicker(

      ${CS.action(context, node, ActionGesture.onTap, 'onPressed: () async', null, isRequired: true)}
      looping: $flag,
      $itemExtent

      ${CS.action(context, node, ActionGesture.onTap, 'onPressed: () async', null, isRequired: true)}

      ${CS.child(context, child, comma: true)}
    )
  ''';
}
