// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// ConstrainedBox Template
class ConstrainedBoxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final minWidth = (body.attributes[DBKeys.minWidth] as FSize)
        .toCode(context: context, isWidth: true);
    final maxWidth = (body.attributes[DBKeys.maxWidth] as FSize)
        .toCode(context: context, isWidth: true);
    final minHeight = (body.attributes[DBKeys.minHeight] as FSize)
        .toCode(context: context, isWidth: false);
    final maxHeight = (body.attributes[DBKeys.maxHeight] as FSize)
        .toCode(context: context, isWidth: false);

    final childString = await CS.child(context, child, comma: true);
    final code = '''
    ConstrainedBox(
      constraints: BoxConstraints(
        ${minWidth != 'null' ? 'minWidth: $minWidth,' : ''} 
        ${minHeight != 'null' ? 'minHeight: $minHeight,' : ''} 
        ${maxWidth != 'null' ? 'maxWidth: $maxWidth,' : ''} 
        ${maxHeight != 'null' ? 'maxHeight: $maxHeight,' : ''} 
      ),
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await CS.child(context, child, comma: true)
        ..replaceAll('child:', '');
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }

  static void testCode() {}
}
