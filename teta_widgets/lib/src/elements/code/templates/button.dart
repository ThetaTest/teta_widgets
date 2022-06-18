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
  final int pageId,
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);

  return '''
    GestureDetector(
      ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onTap,
    'onTap: () async',
    null,
    isRequired: false,
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
      child: Container(
        ${CS.size(context, body, isWidth: true)}
        ${CS.size(context, body, isWidth: false)}
        ${CS.boxDecoration(context, body, DBKeys.fill)}
        child: Center(
            child: Text(
            $value,
            ${CS.textStyle(context, body, DBKeys.textStyle)}
          ),
        )
      ),
    )
  ''';
}
