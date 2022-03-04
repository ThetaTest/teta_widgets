// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// OffStage Template
String offStageCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final offstage = body.attributes[DBKeys.flag] as bool;

  return '''
    Offstage(
      offstage: $offstage,
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
