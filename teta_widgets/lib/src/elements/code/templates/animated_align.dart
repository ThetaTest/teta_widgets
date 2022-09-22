// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for AnimatedAlign widget
class AnimatedAlignCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
    final duration = int.tryParse(
          abstract.toCode(
            loop,
            resultType: ResultTypeEnum.int,
            defaultValue: '400',
          ),
        ) ??
        400;
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    AnimatedAlign(
      duration: const Duration(milliseconds: $duration),
      ${CS.align(body)}
      $childString
    )
  ''';
    final result = FormatterTest.format(code);
    if (result) {
      return code;
    } else {
      return toCode(context, NodeBody.get(NType.animatedAlign), child, loop);
    }
  }

  static void testCode() {
    group('Animated Alignment toCode test', () {
      // default
      test(
        'Default duration',
        () {
          final body = NodeBody.get(NType.animatedAlign);
          final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
          final duration = int.tryParse(
                abstract.toCode(
                  0,
                  resultType: ResultTypeEnum.int,
                  defaultValue: '400',
                ),
              ) ??
              400;
          expect(
            FormatterTest.format('''
            AnimatedAlign(
              duration: const Duration(milliseconds: $duration),
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
      // State
      test(
        'State duration',
        () {
          final body = NodeBody.get(NType.animatedAlign);
          body.attributes[DBKeys.duration] = FTextTypeInput(
            stateName: 'state',
            type: FTextTypeEnum.state,
          );
          final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
          final duration = int.tryParse(
                abstract.toCode(
                  0,
                  resultType: ResultTypeEnum.int,
                  defaultValue: '400',
                ),
              ) ??
              400;
          expect(
            FormatterTest.format('''
            AnimatedAlign(
              duration: const Duration(milliseconds: $duration),
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
      // Param
      test(
        'Param duration',
        () {
          final body = NodeBody.get(NType.animatedAlign);
          body.attributes[DBKeys.duration] = FTextTypeInput(
            paramName: 'param',
            type: FTextTypeEnum.param,
          );
          final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
          final duration = int.tryParse(
                abstract.toCode(
                  0,
                  resultType: ResultTypeEnum.int,
                  defaultValue: '400',
                ),
              ) ??
              400;
          expect(
            FormatterTest.format('''
            AnimatedAlign(
              duration: const Duration(milliseconds: $duration),
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
      // Dataset
      test(
        'Dataset duration',
        () {
          final body = NodeBody.get(NType.animatedAlign);
          body.attributes[DBKeys.duration] = FTextTypeInput(
            datasetName: 'x',
            datasetAttr: 'y',
            type: FTextTypeEnum.dataset,
          );
          final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
          final duration = int.tryParse(
                abstract.toCode(
                  0,
                  resultType: ResultTypeEnum.int,
                  defaultValue: '400',
                ),
              ) ??
              400;
          expect(
            FormatterTest.format('''
            AnimatedAlign(
              duration: const Duration(milliseconds: $duration),
              ${CS.align(body)}
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
