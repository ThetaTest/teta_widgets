// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// IndexedStack Template
Future<String> indexedStackCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
  final int? loop,
) async {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final index = int.tryParse(value) == null
      ? value.replaceAll(r"'''${", '').replaceAll("}'''", '')
      : 0;
  final childrenString = await CS.children(context, children);
  final code = '''
    IndexedStack(
      index: $index,
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
