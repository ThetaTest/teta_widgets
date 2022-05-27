// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Checkbox widget
String checkBoxCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  return '''
    Checkbox(
      value: false,
      ${CS.action(
    context,
    node,
    ActionGesture.onChange,
    'onChanged: (bool? value) async ',
    null,
    isRequired: false,
    loop: loop,
  )}
    )
  ''';
}
