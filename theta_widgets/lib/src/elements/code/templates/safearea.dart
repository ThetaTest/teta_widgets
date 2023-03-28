// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// SafeArea Template
class SafeAreaCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final left = body.attributes[DBKeys.left] as bool;
    final top = body.attributes[DBKeys.top] as bool;
    final right = body.attributes[DBKeys.right] as bool;
    final bottom = body.attributes[DBKeys.bottom] as bool;
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    SafeArea(
      left: $left,
      top: $top,
      right: $right,
      bottom: $bottom,
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

  static void testCode() {
    group('SafeArea toCode test', () {
      test(
        'SafeArea: default code',
        () {
          final body = NodeBody.get(NType.safeArea);
          final left = body.attributes[DBKeys.left] as bool;
          final top = body.attributes[DBKeys.top] as bool;
          final right = body.attributes[DBKeys.right] as bool;
          final bottom = body.attributes[DBKeys.bottom] as bool;
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
             SafeArea(
              left: $left,
              top: $top,
              right: $right,
              bottom: $bottom,
              $childString
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
