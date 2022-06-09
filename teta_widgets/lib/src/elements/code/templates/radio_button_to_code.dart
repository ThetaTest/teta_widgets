import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/index.dart';

class RadioButtonToCode {
  static String toCode(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final FTextTypeInput groupValue,
    final FTextTypeInput value,
    final int loop,
  ) {
    return '''
    Radio<String>(
      value: '${value.value}',
      groupValue: '${groupValue.value}',
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onChange,
      'onChanged: (final value) async',
      null,
      isRequired: true,
      loop: loop,
    )}
    )
  ''';
  }
}
