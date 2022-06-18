// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Condition Template
String conditionCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  var value = abstract.toCode(loop);
  var valueOfCondition =
      (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput).toCode(loop);
  if (!value.contains("'")) {
    value = value;
  }
  if (!valueOfCondition.contains("'")) {
    valueOfCondition = valueOfCondition;
  }
  var childIfTrue = 'const SizedBox()';
  if (children.isNotEmpty) {
    childIfTrue = CS
        .child(context, children.first, comma: false)
        .replaceFirst('child: ', '');
  }
  var childIfFalse = 'const SizedBox()';
  if (children.isNotEmpty && children.length > 1) {
    childIfFalse = CS
        .child(context, children.last, comma: false)
        .replaceFirst('child: ', '');
  }
  return '''
    (($value) == $valueOfCondition) ? $childIfTrue : $childIfFalse
  ''';
}
