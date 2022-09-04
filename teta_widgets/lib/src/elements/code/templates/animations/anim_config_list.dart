// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for ScaleAnimation widget
Future<String> animConfigListCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int loop,
) async {
  final position =
      (body.attributes[DBKeys.value] as FTextTypeInput).toCode(loop);
  final duration =
      (body.attributes[DBKeys.duration] as FTextTypeInput).toCode(loop);
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    AnimationConfiguration.staggeredList(
      position: int.tryParse(
          $position 
          ) ??
          0,
      duration: Duration(
        milliseconds: int.tryParse(
            $duration
            ) ??
            375,
      ),
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    final code = await animConfigListCodeTemplate(
      context,
      NodeBody.get(NType.animationConfigGrid),
      child,
      loop,
    );
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }
}
