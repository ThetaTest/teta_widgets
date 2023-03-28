// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';

/// ClipOval Template
class ClipOvalCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    ClipOval(
      $childString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return '''
    const SizedBox()
    ''';
    }
  }

  static void testCode() {}
}
