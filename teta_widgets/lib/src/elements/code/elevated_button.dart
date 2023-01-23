import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';

import '../index.dart';
import 'formatter_test.dart';

class ElevatedButtonCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    ElevatedButton(
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onTap,
      'onPressed: () async',
      null,
      isRequired: true,
      loop: loop,
    )}
     ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onTap,
      'onHover: () ',
      null,
      isRequired: true,
      loop: loop,
    )}
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onLongPress,
      'onLongPress: () async',
      null,
      isRequired: false,
      loop: loop,
    )}
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