// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Card Template
String cardCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final elevation = double.tryParse(value) != null ? double.parse(value) : '1';
  final fill = FFill.toCode(
    body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  return '''
    Card(
      elevation: $elevation,
      $fill
      ${CS.shapeCardBorderRadius(context, body)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
