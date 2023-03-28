// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';

/// GitHub Login Template
class LoginGitHubCodeTemplate {
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
    child: GithubAuthButton(
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
      return 'const SizedBox()';
    }
  }

  static void testCode() {}
}
