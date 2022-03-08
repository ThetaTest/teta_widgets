// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino AppBar Template. unclassified for now
String cupertinoAppBarCodeTemplate(
  final BuildContext context,
  final NodeBody body,
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
