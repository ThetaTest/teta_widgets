// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Material AppBar Template
String materialAppBarCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) {
  final fill = body.attributes[DBKeys.fill] as FFill;
  final hex = fill.getHexColor(context);

  return '''
    MaterialAppBar(
      color: Color(0xFF$hex).withOpacity(${fill.levels?.first.opacity ?? '1'}),
      ${CS.children(context, children)}
    )
  ''';
}
