// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for BottomBarItem widget
class BottomBarItemCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final icon = body.attributes[DBKeys.icon] as String;
    final fill = FFill.toCode(
      body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
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
      child: Column(
        children:[
          Icon(
            MdiIcons.fromString('$icon'),
            ${CS.size(context, body, isWidth: true).replaceAll('width', 'size')}
            $fill
          ),
          Text($value,
            ${CS.textStyle(context, body, DBKeys.textStyle)}
          )
        ],
      )
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return toCode(
        pageId,
        context,
        NodeBody.get(NType.bottombaritem),
        node,
        child,
        loop,
      );
    }
  }

  static void testCode() {}
}
