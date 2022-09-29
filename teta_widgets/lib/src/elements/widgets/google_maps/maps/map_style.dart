import 'package:teta_widgets/src/elements/constants_export.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/aubergine_map.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/dark_map.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/night_map.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/retro_map.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/silver_map.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/standard_map.dart';

enum MapStyle {
  standard,
  silver,
  retro,
  dark,
  night,
  aubergine,
}

String getMap(final MapStyle mapStyle) {
  switch (mapStyle) {
    case MapStyle.standard:
      return kStandardMap;
    case MapStyle.silver:
      return kSilverMap;
    case MapStyle.retro:
      return kRetroMap;
    case MapStyle.dark:
      return kDarkMap;
    case MapStyle.night:
      return kNightMap;
    case MapStyle.aubergine:
      return kAubergineMap;
  }
}

String getMapToCodeName(final MapStyle mapStyle) {
  switch (mapStyle) {
    case MapStyle.standard:
      return kMapStyleStandard.name;
    case MapStyle.silver:
      return kMapStyleSilver.name;
    case MapStyle.retro:
      return kMapStyleRetro.name;
    case MapStyle.dark:
      return kMapStyleDark.name;
    case MapStyle.night:
      return kMapStyleNight.name;
    case MapStyle.aubergine:
      return kMapStyleAubergine.name;
  }
}
