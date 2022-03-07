// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// LinearProgressIndicator Template
String linearProgressIndicatorCodeTemplate(
  BuildContext context,
  NodeBody body,
  int? loop,
) {
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);
  final bgFill = (body.attributes[DBKeys.bgFill] as FFill).getHexColor(context);

  return '''
    LinearProgressIndicator(
      backgroundColor: Color(0xFF$bgFill), 
      valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF$fill)),
    )
  ''';
}
