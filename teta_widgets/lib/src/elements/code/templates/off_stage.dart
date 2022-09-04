// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// OffStage Template
Future<String> offStageCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) async {
  final offstage = body.attributes[DBKeys.flag] as bool;

  final childString = await CS.child(context, child, comma: true);
  final code = '''
    Offstage(
      offstage: $offstage,
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return 'const SizedBox()';
  }
}
