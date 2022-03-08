// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for BottomBarItem widget
String bottomBarItemCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final icon = body.attributes[DBKeys.icon] as String;
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);
  return '''
    GestureDetector(
      ${CS.action(context, node, ActionGesture.onTap, 'onTap: () async', null, isRequired: false)}
      ${CS.action(context, node, ActionGesture.onLongPress, 'onLongPress: () async', null, isRequired: false)}
      child: Column(
        children:[
          Icon(
            MdiIcons.fromString('$icon'),
            ${CS.size(context, body, isWidth: true).replaceAll('width', 'size')}
            color: Color(0xFF$fill),
          ),
          Text('$value',
            ${CS.textStyle(context, body, DBKeys.textStyle)}
          )
        ],
      )
    )
  ''';
}
