// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// LinearProgressIndicator Template
String linearProgressIndicatorCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final int? loop,
) {
  final colorFill = body.attributes[DBKeys.fill] as FFill;
  final hex1 = colorFill.getHexColor(context);
  final colorBgFill = body.attributes[DBKeys.bgFill] as FFill;
  final hex2 = colorBgFill.getHexColor(context);

  return '''
    LinearProgressIndicator(
      backgroundColor: Color(0xFF$hex2).withOpacity(${colorBgFill.levels?.first.opacity ?? '1'}), 
      valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF$hex1).withOpacity(${colorFill.levels?.first.opacity ?? '1'})),
    )
  ''';
}
