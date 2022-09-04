// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
Future<String> tooltipCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) async {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    Tooltip(
      message: $value,
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
