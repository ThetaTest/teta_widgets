// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Concentric PageView Template
String concentricPageViewCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final List<CNode> children,
) {
  final fill = FFill.toCode(
    body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  final childrenStr =
      CS.children(context, children).replaceFirst('children:', '');
  return '''
    ConcentricPageView(
      colors: [
        ${fill!.replaceAll('color:', '')}
        ${fill.replaceAll('color:', '')}
      ],
      itemCount: ${children.length},
      itemBuilder: (final int index) {
        return ${childrenStr.substring(0, childrenStr.length - 1)}[index];
      },
    )
  ''';
}
