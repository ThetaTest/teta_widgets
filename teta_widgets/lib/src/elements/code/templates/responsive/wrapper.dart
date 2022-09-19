// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
class WrapperCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    BlocBuilder<DeviceModeCubit, DeviceInfo>(
        builder: (context, state) {
          if (state.identifier.type == DeviceType.desktop) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                $childString
              ),
            );
          }
          if (state.identifier.type == DeviceType.tablet) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              $childString
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            $childString
          );
        },
      )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {
    group('Wrapper toCode test', () {
      test(
        'Wrapper: default',
        () {
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
            BlocBuilder<DeviceModeCubit, DeviceInfo>(
        builder: (context, state) {
          if (state.identifier.type == DeviceType.desktop) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                $childString
              ),
            );
          }
          if (state.identifier.type == DeviceType.tablet) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              $childString
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            $childString
          );
        },
      )
            '''),
            true,
          );
        },
      );
    });
  }
}
