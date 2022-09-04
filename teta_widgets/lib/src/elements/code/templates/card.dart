// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Card Template
Future<String> cardCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) async {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final elevation = double.tryParse(value) != null ? double.parse(value) : '1';
  final fill = FFill.toCode(
    body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    Card(
      elevation: $elevation,
      $fill
      ${CS.shapeCardBorderRadius(context, body)}
      $childString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    final code = await cardCodeTemplate(context, body, null, loop);
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await cardCodeTemplate(
        context,
        NodeBody.get(NType.card),
        child,
        loop,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return cardCodeTemplate(context, NodeBody.get(NType.card), null, loop);
      }
    }
  }
}
