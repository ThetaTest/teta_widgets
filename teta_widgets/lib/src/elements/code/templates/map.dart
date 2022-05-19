// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Map Template
String mapCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final List<CNode> children,
  final int? loop,
) {
  final abstract = body.attributes[DBKeys.valueOfCondition] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final flag = body.attributes[DBKeys.flag] as bool;
  final mapBoxKey =
      (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
          .prj
          .config
          ?.mapboxKey;

  return '''
map.MapLayoutBuilder(
  controller: map.MapController(
    location: LatLng(41.52, 12.30),
    zoom: 4,
  ),
  builder: (context, transformer) {
    return Stack(
      children: [
        map.Map( 
          controller: map.MapController(
            location: LatLng(41.52, 12.30),
            zoom: 4,
          ),
          builder: (context, x, y, z) {
            final url = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/\$z/\$x/\$y?access_token=$mapBoxKey';
            final darkUrl = 'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/\$z/\$x/\$y?access_token=$mapBoxKey';
            return Image.network(
              $flag ? darkUrl : url,
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
