// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// OffStage Template
String offStageCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) {
  final offstage = body.attributes[DBKeys.flag] as bool;

  return '''
    Offstage(
      offstage: $offstage,
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
