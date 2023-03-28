// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/features/actions/enums/gestures.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';

/// GestureDetector Template
class GestureDetectorCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
    final onTap = CS.action(
      pageId,
      context,
      node,
      ActionGesture.onTap,
      'onTap: () async',
      null,
      isRequired: false,
      loop: loop,
    );
    final onDoubleTap = CS.action(
      pageId,
      context,
      node,
      ActionGesture.onDoubleTap,
      'onDoubleTap: () async',
      null,
      isRequired: false,
      loop: loop,
    );
    final onLongPress = CS.action(
      pageId,
      context,
      node,
      ActionGesture.onLongPress,
      'onLongPress: () async',
      null,
      isRequired: false,
      loop: loop,
    );
    if (onTap.isEmpty && onDoubleTap.isEmpty && onLongPress.isEmpty) {
      return CS.child(
        context,
        child,
        comma: false,
        withChild: false,
      );
    }
    final childString = await CS.child(context, child, comma: true);
    final code = '''
  GestureDetector(
    $onTap
    $onDoubleTap
    $onLongPress
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
