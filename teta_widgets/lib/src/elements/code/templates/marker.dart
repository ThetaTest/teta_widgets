// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String markerCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int? loop,
) {
  final valLat =
      (body.attributes[DBKeys.latitude] as FTextTypeInput).toCode(loop);
  final lat = double.tryParse(valLat) != null ? double.parse(valLat) : '41.90';

  final valLng =
      (body.attributes[DBKeys.longitude] as FTextTypeInput).toCode(loop);
  final lng = double.tryParse(valLng) != null ? double.parse(valLng) : '12.49';

  return '''
  Positioned(
      left: $lat,
      top: $lng,
      child: GestureDetector(
        ${CS.child(context, child, comma: true)}
      ),
    )
  ''';
}
