// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Image Template
class ImageCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.image] as FTextTypeInput;
    final value = abstract.toCode(loop);
    final borderRadius = CS.borderRadius(context, body);
    final code = '''
    ${borderRadius != '' ? 'ClipRRect( ${CS.borderRadius(context, body)} child:' : ''} 
        Image.network(
          ${abstract.type == FTextTypeEnum.text || abstract.type == FTextTypeEnum.asset ? "r$value" : value},
          ${CS.size(context, body, isWidth: true)}
          ${CS.size(context, body, isWidth: false)}
          ${CS.boxFit(context, body)}
        )
    ${borderRadius != '' ? ',)' : ''}
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {}
}
