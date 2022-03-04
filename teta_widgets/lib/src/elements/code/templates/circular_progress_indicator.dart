// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/features/fill.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// CircularProgressIndicator Template
String circularProgressIndicatorCodeTemplate(
  BuildContext context,
  NodeBody body,
  int? loop,
) {
  final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);

  return '''
    CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF$fill)),
    )
  ''';
}
