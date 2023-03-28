// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for Parallax widget
class ParallaxCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final mainAxisExtent = CS
        .size(context, body, isWidth: false)
        .replaceFirst('height:', 'mainAxisExtent:');
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    Parallax.inside(
      $mainAxisExtent
      ${CS.size(context, body, isWidth: false)}
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
