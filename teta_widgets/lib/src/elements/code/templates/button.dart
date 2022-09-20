// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

class ButtonCodeTemplate {
  /// Generates the code for Button widget
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final int loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
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
      return toCode(
        pageId,
        context,
        NodeBody.get(NType.button),
        node,
        loop,
      );
    }
  }

  static void testCode() {
    group('Button toCode test', () {
      test(
        'Button: Text Value',
        () {
          final value = FTextTypeInput(value: 'xxx').toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
            GestureDetector(
              onTap: () async {},
              onLongPress: () async {},
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text($value),
                ),
               )
            )
            '''),
            true,
          );
        },
      );
      test(
        'Button: State Value',
        () {
          final value =
              FTextTypeInput(stateName: 'state', type: FTextTypeEnum.state)
                  .toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
            GestureDetector(
              onTap: () async {},
              onLongPress: () async {},
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text($value),
                ),
               )
            )
            '''),
            true,
          );
        },
      );
      test(
        'Button: Param Value',
        () {
          final value =
              FTextTypeInput(paramName: 'param', type: FTextTypeEnum.param)
                  .toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
            GestureDetector(
              onTap: () async {},
              onLongPress: () async {},
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text($value),
                ),
               )
            )
            '''),
            true,
          );
        },
      );
      test(
        'Button: Dataset Value',
        () {
          final value = FTextTypeInput(
            datasetName: 'xxx',
            datasetAttr: 'yyy',
            type: FTextTypeEnum.dataset,
          ).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format('''
            GestureDetector(
              onTap: () async {},
              onLongPress: () async {},
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text($value),
                ),
               )
            )
            '''),
            true,
          );
        },
      );
    });
  }
}
