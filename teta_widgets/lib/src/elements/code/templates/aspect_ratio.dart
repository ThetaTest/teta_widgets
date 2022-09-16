// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// AspectRatio Template
class AspectRatioCodeTemplate {
  static Future<String> toCode(
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
      final code = await toCode(
        context,
        NodeBody.get(NType.aspectRatio),
        null,
        0,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }

  static void testCode() {
    group('AspectRatio toCode test', () {
      test(
        'AspectRatio: default',
        () {
          final body = NodeBody.get(NType.aspectRatio);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final value = abstract.toCode(0);
          final aspectRatio =
              double.tryParse(value) != null ? double.parse(value) : '0.5';
          expect(
            FormatterTest.format('''
             AspectRatio(
              aspectRatio: $aspectRatio,
              child: const SizedBox(),
            )'''),
            true,
          );
        },
      );
    });
  }
}
