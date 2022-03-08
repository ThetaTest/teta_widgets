// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// DecoratedBox Template
String decoratedBoxCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  return '''
    DecoratedBox(
      ${CS.boxDecoration(context, body, DBKeys.fill)}
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
