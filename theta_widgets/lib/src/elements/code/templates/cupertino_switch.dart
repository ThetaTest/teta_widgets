// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/features/actions/enums/gestures.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Cupertino Switch Template
class CupertinoSwitchCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
    final code = '''
    CupertinoSwitch(
      value: false,
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onChange,
      'onChanged: (value) async',
      'false',
      isRequired: true,
      loop: loop,
    )}
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
