// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// ConstrainedBox Template
String constrainedBoxCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode? child,
  int? loop,
) {
  final minWidth = (body.attributes[DBKeys.minWidth] as FSize)
      .toCode(context: context, isWidth: true);
  final maxWidth = (body.attributes[DBKeys.maxWidth] as FSize)
      .toCode(context: context, isWidth: true);
  final minHeight = (body.attributes[DBKeys.minHeight] as FSize)
      .toCode(context: context, isWidth: false);
  final maxHeight = (body.attributes[DBKeys.maxHeight] as FSize)
      .toCode(context: context, isWidth: false);

  return '''
    ConstrainedBox(
      constraints: BoxConstraints(
        ${minWidth != 'null' ? 'minWidth: $minWidth,' : ''} 
        ${minHeight != 'null' ? 'minHeight: $minHeight,' : ''} 
        ${maxWidth != 'null' ? 'maxWidth: $maxWidth,' : ''} 
        ${maxHeight != 'null' ? 'maxHeight: $maxHeight,' : ''} 
      ),
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
