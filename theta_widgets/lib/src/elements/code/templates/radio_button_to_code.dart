import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/index.dart';

///Generates code for Radio widget
class RadioButtonTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final FTextTypeInput groupValue,
    final FTextTypeInput value,
    final int loop,
  ) async {
    final code = '''
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
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }
}
