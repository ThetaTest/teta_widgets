// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino Picker Template
class CupertinoPickerCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final List<CNode> children,
    final int loop,
  ) async {
    final flag = body.attributes[DBKeys.flag] as bool;
    final itemExtent = CS
        .size(context, body, isWidth: false)
        .replaceFirst('height:', 'itemExtent:');

    final childrenString = await CS.children(context, children);

    final code = '''
    CupertinoPicker(
      looping: $flag,
      $itemExtent
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onChange,
      'onSelectedItemChanged: (int) async',
      'false',
      isRequired: true,
      loop: loop,
    )}
      $childrenString
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
