// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Bouncing widget
Future<String> bouncingWidgetCodeTemplate(
  final int pageId,
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int loop,
) async {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final duration = int.tryParse(value) != null ? int.parse(value) : '200';
  final valueOfCondition =
      (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput).toCode(loop);
  final scale = double.tryParse(valueOfCondition) ?? 1;
  final actionString = CS.action(
    pageId,
    context,
    node,
    ActionGesture.onTap,
    'onPressed: () async',
    null,
    isRequired: false,
    loop: loop,
  );
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    BouncingWidget(
      ${actionString != '' ? actionString : 'onPressed: () async {},'}
      duration: const Duration(milliseconds: $duration),
      scaleFactor: $scale,
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    final code = await bouncingWidgetCodeTemplate(
      pageId,
      context,
      body,
      node,
      null,
      loop,
    );
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await bouncingWidgetCodeTemplate(
        pageId,
        context,
        NodeBody.get(NType.bouncingWidget),
        node,
        child,
        loop,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return bouncingWidgetCodeTemplate(
          pageId,
          context,
          NodeBody.get(NType.bouncingWidget),
          node,
          null,
          loop,
        );
      }
    }
  }
}
