// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Button widget
Future<String> buttonCodeTemplate(
  final int pageId,
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final int loop,
) async {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);

  final code = '''
    GestureDetector(
      ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onTap,
    'onTap: () async',
    null,
    isRequired: false,
    loop: loop,
  )}
      ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onLongPress,
    'onLongPress: () async',
    null,
    isRequired: false,
    loop: loop,
  )}
      child: Container(
        ${CS.size(context, body, isWidth: true)}
        ${CS.size(context, body, isWidth: false)}
        ${CS.boxDecoration(context, body, DBKeys.fill)}
        child: Center(
            child: Text(
            $value,
            ${CS.textStyle(context, body, DBKeys.textStyle)}
          ),
        )
      ),
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return buttonCodeTemplate(
      pageId,
      context,
      NodeBody.get(NType.button),
      node,
      loop,
    );
  }
}
