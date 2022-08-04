import 'package:teta_core/src/models/package.dart';

///This file contains all the packages we support & export in each app.
const PackageModel pLottie = PackageModel(
  packageName: 'lottie',
  packageVersion: '1.3.0',
  isDart: false,
);
const PackageModel pFlutterStaggeredAnimations = PackageModel(
  packageName: 'flutter_staggered_animations',
  packageVersion: '1.0.0',
  isDart: false,
);
const PackageModel pAuthButton = PackageModel(
  packageName: 'auth_buttons',
  packageVersion: '2.0.4',
  isDart: false,
);
//todo: optimize later - unused - right now is a default import
const PackageModel pSupabase = PackageModel(
  packageName: 'supabase',
  packageVersion: '0.3.4+1',
  isDart: false,
);
//todo: optimize later - unused - right now is a default import
const PackageModel pFlutterSupabase = PackageModel(
  packageName: 'supabase_flutter',
  packageVersion: '0.3.1+3',
  isDart: false,
);
//todo: optimize later - unused - right now is a default import
const PackageModel pGoogleMobileAds = PackageModel(
  packageName: 'google_mobile_ads',
  packageVersion: '1.2.0',
  isDart: false,
  customPath: "import 'package:google_mobile_ads/google_mobile_ads.dart';",
);
//todo: optimize later - unused - right now is a default import
const PackageModel pFlutterStripe = PackageModel(
  packageName: 'flutter_stripe',
  packageVersion: '3.1.0',
  isDart: false,
);
//todo: optimize later - unused - right now is a default import
const PackageModel pHttp = PackageModel(
  packageName: 'http',
  packageVersion: '0.13.4',
  isDart: false,
  extraCode: 'as http',
);

const PackageModel pIntl = PackageModel(
  packageName: 'intl',
  packageVersion: '0.17.0',
  isDart: false,
  extraCode: 'hide TextDirection',
);
const PackageModel pBadges = PackageModel(
  packageName: 'badges',
  packageVersion: '2.0.3',
  isDart: false,
);
const PackageModel pBouncingWidget = PackageModel(
  packageName: 'bouncing_widget',
  packageVersion: '2.0.0',
  isDart: false,
);
const PackageModel pPagedVerticalCalendar = PackageModel(
  packageName: 'paged_vertical_calendar',
  packageVersion: '1.1.3',
  isDart: false,
);
const PackageModel pConcentricTransition = PackageModel(
  packageName: 'concentric_transition',
  packageVersion: '1.0.3',
  isDart: false,
);
const PackageModel pMaterialDesignIconsFlutter = PackageModel(
  packageName: 'material_design_icons_flutter',
  packageVersion: '5.0.6595',
  isDart: false,
);
//unused
const PackageModel pLiquidSwipe = PackageModel(
  packageName: 'liquid_swipe',
  packageVersion: '2.1.1',
  isDart: false,
);
const PackageModel pMap = PackageModel(
  packageName: 'map',
  packageVersion: '1.0.0',
  isDart: false,
  extraCode: 'as map',
);
const PackageModel pGoogleMaps = PackageModel(
  packageName: 'google_maps_flutter',
  packageVersion: '2.1.9',
  isDart: false,
  customPath: '''
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'dart:async';
  import 'dart:typed_data';
  import 'dart:ui';
  ''',
);
const PackageModel pFlutterCacheManager = PackageModel(
  packageName: 'flutter_cache_manager',
  packageVersion: '3.3.0',
  isDart: false,
  customPath: '''
    import 'package:flutter_cache_manager/flutter_cache_manager.dart';
    import 'package:flutter_cache_manager/file.dart';
    ''',
);
const PackageModel pLatLang = PackageModel(
  packageName: 'latlng',
  packageVersion: '0.1.0',
  isDart: false,
);
const PackageModel pQrFlutter = PackageModel(
  packageName: 'qr_flutter',
  packageVersion: '4.0.0',
  isDart: false,
);
const PackageModel pTCard = PackageModel(
  packageName: 'tcard',
  packageVersion: '1.3.5',
  isDart: false,
);
const PackageModel pYoutubePlayerIframe = PackageModel(
  packageName: 'youtube_player_iframe',
  packageVersion: '2.3.0',
  isDart: false,
);
const PackageModel pWebviewX = PackageModel(
  packageName: 'webviewx',
  packageVersion: '0.2.1',
  isDart: false,
);
const PackageModel pFontAwesomeNamed = PackageModel(
  packageName: 'font_awesome_flutter_named',
  packageVersion: '1.1.1',
  isDart: false,
);
const PackageModel pFeatherIcons = PackageModel(
  packageName: 'feather_icons',
  packageVersion: '1.2.0',
  isDart: false,
);
const PackageModel pLineIcons = PackageModel(
  packageName: 'line_icons',
  packageVersion: '2.0.1',
  isDart: false,
);
const PackageModel pUrlLauncher = PackageModel(
  packageName: 'url_launcher',
  packageVersion: '6.1.4',
  isDart: false,
  customPath: "import 'package:url_launcher/url_launcher_string.dart';",
);
//todo: optimize later - unused - right now is a default import
const PackageModel pIO = PackageModel(
  packageName: 'io',
  packageVersion: '',
  isDart: true,
);
//todo: optimize later - unused - right now is a default import
const PackageModel pUI = PackageModel(
  packageName: 'ui',
  packageVersion: '',
  isDart: true,
);
//todo: optimize later - unused - right now is a default import
const PackageModel pConvert = PackageModel(
  packageName: 'convert',
  packageVersion: '3.0.2',
  isDart: true,
);
const PackageModel pJustAudio = PackageModel(
  packageName: 'just_audio',
  packageVersion: '0.9.27',
  isDart: false,
  customPath: "import 'package:just_audio/just_audio.dart';",
);
const PackageModel pRxDart = PackageModel(
  packageName: 'rxdart',
  packageVersion: '0.27.4',
  isDart: false,
  customPath: "import 'package:rxdart/rxdart.dart';",
);
