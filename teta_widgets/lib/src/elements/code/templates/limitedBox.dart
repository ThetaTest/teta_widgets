// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';

/// LimitedBox Template
class LimitedBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final maxWidth = (body.attributes[DBKeys.maxWidth] as FSize)
        .toCode(context: context, isWidth: true);
    final maxHeight = (body.attributes[DBKeys.maxHeight] as FSize)
        .toCode(context: context, isWidth: false);
    final childString = await CS.child(context, child, comma: true);

    final code = '''
    LimitedBox(
        ${maxWidth != 'null' ? 'maxWidth: $maxWidth,' : ''}
        ${maxHeight != 'null' ? 'maxHeight: $maxHeight,' : ''}

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

  static void testCode() {}
}
