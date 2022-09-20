// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for AnimatedOpacity widget

class AnimatedOpacityCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.int,
    );
    //! This is wrong. Int should be retrieved from the toCode func
    final rawDouble = double.tryParse(value.replaceAll('-', '')) != null
        ? double.parse(value.replaceAll('-', ''))
        : 1.0;
    final opacity = rawDouble < 0
        ? 0
        : rawDouble > 1
            ? 1
            : rawDouble;
    final duration = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '400',
    );
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    AnimatedOpacity(
      duration: const Duration(milliseconds: $duration ),
      opacity: $opacity,
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return toCode(
        context,
        NodeBody.get(NType.animatedOpacity),
        null,
        0,
      );
    }
  }
}
