import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/index.dart';

class RadioButtonToCode {
  static String toCode(
    final BuildContext context,
    final CNode node,
    final FTextTypeInput groupValue,
    final FTextTypeInput value,
  ) {
    return '''
    Radio<String>(
      value: '${value.value}',
      groupValue: '${groupValue.value}',
      ${CS.action(context, node, ActionGesture.onChange, 'onChanged: (final value) async', null, isRequired: true)}
    )
  ''';
  }
}
