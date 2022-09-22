// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

///Generates the code for TextField widget
class TextFieldCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int loop,
  ) async {
    final labelText =
        (body.attributes[DBKeys.labelText] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final maxLines =
        (body.attributes[DBKeys.maxLines] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1',
    );
    final minLines =
        (body.attributes[DBKeys.minLines] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1',
    );
    final maxLenght =
        (body.attributes[DBKeys.maxLenght] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: 'null',
    );
    final obscureText = body.attributes[DBKeys.obscureText] as bool? ?? false;
    final showCursor = body.attributes[DBKeys.showCursor] as bool? ?? false;
    final autoCorrect = body.attributes[DBKeys.autoCorrect] as bool? ?? false;
    final fillToCodeColor = FFill.toCode(
      body.attributes[DBKeys.fill] as FFill,
      context,
      flagConst: false,
    );
    final fillHintToCodeColor = FFill.toCode(
      body.attributes[DBKeys.hintTextColor] as FFill,
      context,
      flagConst: false,
    );
    final bordersEnabled =
        body.attributes[DBKeys.showBorders] as bool? ?? false;
    final enabledBorderToCodeColor = FFill.toCode(
      body.attributes[DBKeys.enabledBorderColor] as FFill,
      context,
      flagConst: false,
    );
    final focusedBorderToCodeColor = FFill.toCode(
      body.attributes[DBKeys.focusedBorderColor] as FFill,
      context,
      flagConst: false,
    );
    final borderSize =
        (body.attributes[DBKeys.bordersSize] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1',
    );

    final code = """
  Container(
    ${CS.margin(context, body, isMargin: true)}
    ${CS.size(context, body, isWidth: true)}
    ${CS.boxDecoration(context, body, DBKeys.fill)}
    child: TextField(
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onChange,
      'onChanged: (String value) async',
      null,
      isRequired: true,
      loop: loop,
      withValue: true,
    )}
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onSubmitted,
      'onSubmitted: (String value) async',
      null,
      isRequired: false,
      loop: loop,
      withValue: true,
    )}
      decoration: InputDecoration(
        filled: true,
        ${fillToCodeColor != null ? fillToCodeColor.replaceAll('color', 'fillColor') : ''}
        counterStyle: TextStyle(
                $fillToCodeColor),
        border: OutlineInputBorder(
          ${CS.borderRadius(context, body)}
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(${bordersEnabled ? enabledBorderToCodeColor ?? 'color: Colors.transparent,' : 'color: Colors.transparent,'} width: $borderSize),
          ${CS.borderRadius(context, body)}
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(${bordersEnabled ? focusedBorderToCodeColor ?? 'color: Colors.transparent,' : 'color: Colors.transparent,'} width: $borderSize),
          ${CS.borderRadius(context, body)}
        ),  
        hintText: r$labelText,
        hintStyle: TextStyle(
                $fillHintToCodeColor),
        ${CS.margin(context, body, isMargin: false).replaceAll('padding', 'contentPadding')}
      ),
      ${CS.textStyle(context, body, DBKeys.textStyle)}
      ${maxLines != '1' ? 'maxLines: $maxLines,' : ''}
      minLines: $minLines,
      ${maxLenght != 'null' ? 'maxLength: $maxLenght,' : ''}
      ${obscureText != false ? 'obscureText: $obscureText,' : ''}
      showCursor: $showCursor,
      autocorrect: $autoCorrect,
    ),
  )
  """;
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    return true;
  }

  static void testCode() {
    group('TextField toCode test', () {
      test(
        'TextField: default code',
        () {
          final body = NodeBody.get(NType.textField);
          final labelText =
              (body.attributes[DBKeys.labelText] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final maxLines =
              (body.attributes[DBKeys.maxLines] as FTextTypeInput).getRawToCode(
            0,
            resultType: ResultTypeEnum.int,
            defaultValue: '1',
          );
          final minLines =
              (body.attributes[DBKeys.minLines] as FTextTypeInput).getRawToCode(
            0,
            resultType: ResultTypeEnum.int,
            defaultValue: '1',
          );
          final maxLenght =
              (body.attributes[DBKeys.maxLenght] as FTextTypeInput)
                  .getRawToCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          final obscureText =
              body.attributes[DBKeys.obscureText] as bool? ?? false;
          final showCursor =
              body.attributes[DBKeys.showCursor] as bool? ?? false;
          final autoCorrect =
              body.attributes[DBKeys.autoCorrect] as bool? ?? false;
          final fillToCodeColor =
              FFill.toCodeTests(FFill().ready(FFillType.solid));
          final fillHintToCodeColor =
              FFill.toCodeTests(FFill().ready(FFillType.solid));
          final bordersEnabled =
              body.attributes[DBKeys.showBorders] as bool? ?? false;
          final enabledBorderToCodeColor =
              FFill.toCodeTests(FFill().ready(FFillType.solid));
          final focusedBorderToCodeColor =
              FFill.toCodeTests(FFill().ready(FFillType.solid));
          final borderSize =
              (body.attributes[DBKeys.bordersSize] as FTextTypeInput)
                  .getRawToCode(
            0,
            resultType: ResultTypeEnum.double,
            defaultValue: '1',
          );
          expect(
            FormatterTest.format('''
TextField(
  onChanged: (String value) async {},
  onSubmitted: (String value) async {},
  decoration: InputDecoration(
        filled: true,
        ${fillToCodeColor != null ? fillToCodeColor.replaceAll('color', 'fillColor') : ''}
        counterStyle: TextStyle(
                $fillToCodeColor),
        border: OutlineInputBorder(
         borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(${bordersEnabled ? enabledBorderToCodeColor ?? 'color: Colors.transparent,' : 'color: Colors.transparent,'} width: $borderSize),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(${bordersEnabled ? focusedBorderToCodeColor ?? 'color: Colors.transparent,' : 'color: Colors.transparent,'} width: $borderSize),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),  
        hintText: r$labelText,
        hintStyle: TextStyle($fillHintToCodeColor),
      ),
      maxLines: $maxLines,
      minLines: $minLines,
      maxLength: $maxLenght,
      obscureText: $obscureText,
      showCursor: $showCursor,
      autocorrect: $autoCorrect,
)
              '''),
            true,
          );
        },
      );
    });
  }
}
