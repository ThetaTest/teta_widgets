// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for badge widget
String badgeCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);
  return '''
    Badge(
      badgeContent: Text( 
        $value,
        ${CS.textStyle(context, body, DBKeys.textStyle)}
        ),
      badgeColor:Color(0xFF$fill),
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
