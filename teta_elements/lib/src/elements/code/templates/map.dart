// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/src/elements/code/snippets.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/features/text_type_input.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Map Template
String mapCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  CNode? child,
  List<CNode> children,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.valueOfCondition] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final flag = body.attributes[DBKeys.flag] as bool;

  return '''
MapLayoutBuilder(
  controller: MapController(
    location: LatLng(41.52, 12.30),
    zoom: 4,
  ),
  builder: (context, transformer) {
    return Stack(
      children: [
        Map( 
          controller: MapController(
            location: LatLng(41.52, 12.30),
            zoom: 4,
          ),
          builder: (context, x, y, z) {
            final url = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/\$z/\$x/\$y?access_token=$value';
            final darkUrl = 'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/\$z/\$x/\$y?access_token=$value';
            return Image.network(
              $flag ? darkUrl : url,
              ${CS.size(context, body, isWidth: true)}
              ${CS.size(context, body, isWidth: false)}
              fit: BoxFit.cover,
            );
          },
        ),
      ],
    );
  },
)  
 ''';
}
