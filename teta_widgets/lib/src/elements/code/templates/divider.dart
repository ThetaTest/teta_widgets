// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Divider Template
String dividerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  final fill = FFill.toCode(
    body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  return '''
    Divider(
      ${CS.size(context, body, isWidth: false)}
      $fill
    )
  ''';
}
