// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Placeholder Template
Future<String> placeholderCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
  final int? loop,
) async {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final strokeWidth =
      double.tryParse(value) != null ? double.parse(value) : 2.0;
  final fill = FFill.toCode(
    body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  final childString = await CS.child(context, child, comma: true);
  final code = '''
    Placeholder(
      strokeWidth: $strokeWidth,
      $fill
      fallbackWidth: ${(body.attributes[DBKeys.width] as FSize).size},
      fallbackHeight: ${(body.attributes[DBKeys.height] as FSize).size},
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
