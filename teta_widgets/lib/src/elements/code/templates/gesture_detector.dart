// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// GestureDetector Template
Future<String> gestureDetectorCodeTemplate(
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
