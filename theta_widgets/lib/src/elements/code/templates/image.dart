// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Image Template
class ImageCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.image] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final borderRadius = CS.borderRadius(context, body);
    final code = '''
    ${borderRadius != '' ? 'ClipRRect( ${CS.borderRadius(context, body)} child:' : ''} 
        Image.network(
          ${abstract.type == FTextTypeEnum.text || abstract.type == FTextTypeEnum.asset ? value : value},
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
