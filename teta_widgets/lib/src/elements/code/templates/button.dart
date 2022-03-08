// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Button widget
String buttonCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  CNode? child,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);

  return '''
    GestureDetector(
      ${CS.action(context, node, ActionGesture.onTap, 'onTap: () async', null, isRequired: false)}
      ${CS.action(context, node, ActionGesture.onLongPress, 'onLongPress: () async', null, isRequired: false)}
      child: Container(
        ${CS.size(context, body, isWidth: true)}
        ${CS.size(context, body, isWidth: false)}
        ${CS.boxDecoration(context, body, DBKeys.fill)}
        child: Text(
          '$value',
          ${CS.textStyle(context, body, DBKeys.textStyle)}
        ),
      ),
    )
  ''';
}
