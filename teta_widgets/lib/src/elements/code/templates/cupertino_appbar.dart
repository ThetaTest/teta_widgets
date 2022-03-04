// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino AppBar Template
String cupertinoAppBarCodeTemplate(
  BuildContext context,
  NodeBody body,
) {
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);

  return '''
    CupertinoAppBar(
      backgroundColor: HexColor(
              Color(0xFF$fill),
              ),
    )
  ''';
}
