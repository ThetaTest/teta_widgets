// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Animated Container Template
Future<String> animatedContainerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) async {
  final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final duration = int.tryParse(value) != null ? int.parse(value) : '400';
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    AnimatedContainer(
      duration: const Duration(milliseconds: $duration),
      ${CS.margin(context, body, isMargin: true)}
      ${CS.margin(context, body, isMargin: false)}
      ${CS.size(context, body, isWidth: true)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.boxDecoration(context, body, DBKeys.fill)}
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return animatedContainerCodeTemplate(
      context,
      NodeBody.get(NType.animatedContainer),
      null,
      loop,
    );
  }
}
