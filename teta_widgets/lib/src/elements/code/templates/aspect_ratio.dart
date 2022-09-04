// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// AspectRatio Template
Future<String> aspectRatioCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) async {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final aspectRatio =
      double.tryParse(value) != null ? double.parse(value) : '0.5';

  final childString = await CS.child(context, child, comma: true);
  final code = '''
    AspectRatio(
      aspectRatio: $aspectRatio,
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return aspectRatioCodeTemplate(
      context,
      NodeBody.get(NType.aspectRatio),
      null,
      loop,
    );
  }
}
