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
  BuildContext context,
  NodeBody body,
  List<CNode> children,
) {
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);

  return '''
    MaterialAppBar(
      color: Color(0xFF$fill),
      ${CS.children(context, children)}
    )
  ''';
}
