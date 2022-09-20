// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Refresh Indicator widget
class RefreshIndicatorCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final List<CNode> children,
    final int loop,
  ) async {
    final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
    final duration = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1000',
    );
    final childrenString = await CS.children(context, children);
    final code = '''
    RefreshIndicator(
      duration: const Duration(milliseconds: $duration),
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onTap,
      'onPressed: () async',
      null,
      isRequired: false,
      loop: loop,
    )}
      ${CS.size(context, body, isWidth: false)}
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
