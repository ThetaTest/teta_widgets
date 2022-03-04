// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/features/text_type_input.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Image Template
String imageCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.image] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final borderRadius = CS.borderRadius(context, body);
  return '''
    ${borderRadius != '' ? 'ClipRRect( ${CS.borderRadius(context, body)} child:' : ''} 
        Image.network(
          ${abstract.type == FTextTypeEnum.text || abstract.type == FTextTypeEnum.asset ? "r'''$value'''" : value},
          ${CS.size(context, body, isWidth: true)}
          ${CS.size(context, body, isWidth: false)}
          ${CS.boxFit(context, body)}
        )
    ${borderRadius != '' ? ',)' : ''}
  ''';
}
