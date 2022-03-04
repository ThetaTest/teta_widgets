// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String ignorePointerCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
) {
  final flag = body.attributes[DBKeys.flag] as bool;
  return '''
    IgnorePointer(
      ignoring: $flag,
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
