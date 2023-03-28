// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Map Template
class MapCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final List<CNode> children,
    final int? loop,
  ) async {
    final flag = body.attributes[DBKeys.flag] as bool;
    final mapBoxKey =
        (BlocProvider.of<ConfigCubit>(context).state as ConfigStateLoaded)
            .config
            .mapboxKey;

    final code = '''
map.MapLayoutBuilder(
  controller: map.MapController(
    location: latlng.LatLng(41.52, 12.30),
    zoom: 4,
  ),
  builder: (context, transformer) {
    return Stack(
      children: [
        map.Map( 
          controller: map.MapController(
            location: latlng.LatLng(41.52, 12.30),
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
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {}
}
