// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/index.dart';

/// Apple Login Template
class LoginAppleCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
    final code = '''
SizedBox(
    ${CS.size(context, node.body, isWidth: true)}
    ${CS.size(context, node.body, isWidth: false)}
    child: AppleAuthButton(
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
      ActionGesture.onLongPress,
      'onLongPress: () async',
      null,
      isRequired: false,
      loop: loop,
    )}
    ),
  )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return toCode(
        pageId,
        context,
        node,
        null,
        loop,
      );
    }
  }

  static void testCode() {}
}
