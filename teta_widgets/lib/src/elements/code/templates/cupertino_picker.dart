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
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final List<CNode> children,
  final int loop,
) {
  final flag = body.attributes[DBKeys.flag] as bool;
  final itemExtent = CS
      .size(context, body, isWidth: false)
      .replaceFirst('height:', 'itemExtent:');

  return '''
    CupertinoPicker(
      looping: $flag,
      $itemExtent
      ${CS.action(
    context,
    node,
    ActionGesture.onChange,
    'onSelectedItemChanged: (int) async',
    'false',
    isRequired: true,
    loop: loop,
  )}
      ${CS.children(
    context,
    children,
  )}
    )
  ''';
}
