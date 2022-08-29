// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for FeatherIcon widget
String iconLineCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int? loop,
) {
  final icon = node.body.attributes[DBKeys.lineIcon] as String;
  final fill = FFill.toCode(
    node.body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  return '''
    Icon (
      LineIcons.byName('$icon'),
      ${CS.size(context, body, isWidth: true).replaceAll('width', 'size')}
      $fill
    )
  ''';
}
