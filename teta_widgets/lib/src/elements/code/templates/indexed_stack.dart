// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// IndexedStack Template
String indexedStackCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final index = int.tryParse(value) == null
      ? value.replaceAll(r"'''${", '').replaceAll("}'''", '')
      : 0;
  return '''
    IndexedStack(
      index: $index,
      ${CS.children(context, children)}
    )
  ''';
}
