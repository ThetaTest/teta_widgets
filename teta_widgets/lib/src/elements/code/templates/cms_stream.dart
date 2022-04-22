// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for Padding widget
String cmsStreamCodeTemplate(
  final BuildContext context,
  final NDynamic node,
  final List<CNode> children,
  final int? loop,
) {
  var collectionId =
      (node.body.attributes[DBKeys.cmsCollection] as FTextTypeInput)
          .toCode(loop);
  if (!collectionId.contains("'")) {
    collectionId = "'$collectionId'";
  }

  var child = 'const SizedBox()';
  if (children.isNotEmpty) {
    child = children.first.toCode(context);
  }
  var loader = 'const CircularProgressIndicator()';
  if (children.length >= 2) {
    loader = children[1].toCode(context);
  }
  final func = '''
  final list = snapshot.data as List<dynamic>?;
  datasets['${node.name ?? node.intrinsicState.displayName}'] = list ?? const <dynamic>[];
  const index = 0;
  ''';

  return '''
  StreamBuilder(
    stream: TetaCMS.instance.client.streamCollection($collectionId),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      $func
      return $child;
    }
  )
  ''';
}
