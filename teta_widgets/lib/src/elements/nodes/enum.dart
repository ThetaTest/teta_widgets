// Package imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:enum_to_string/enum_to_string.dart';

enum NType {
  align,
  badge,
  button,
  center,
  checkbox,
  column,
  component,
  condition,
  container,
  decoratedBox,
  divider,
  expanded,
  gestureDetector,
  gridView,
  gridViewBuilder,
  hero,
  icon,
  ignorePointer,
  image,
  liquidSwipe,
  listView,
  listViewBuilder,
  listViewSeparated,
  lottie,
  opacity,
  outlinedButton,
  padding,
  pageView,
  positioned,
  responsiveCondition,
  row,
  safeArea,
  scaffold,
  sizedBox,
  spacer,
  stack,
  text,
  textButton,
  textField,
  video,
  wrap,
  appBar,
  bottomBar,
  drawer,
  firebaseFutureBuilder,
  firebaseStreamBuilder,
  firebasePagination,
  firebaseIsAuthenticated,
  loginWithApple,
  loginWithGoogle,
  loginWithFacebook,
  loginWithGitHub,
  loginWithTwitter,
  nil,
  materialAppBar,
  cupertinoAppBar,
  materialBottomBar,
  exampleWP,
  radio,
  tooltip,
  bottombaritem,
  clipRect,
  clipRoundedRect,
  linearProgressIndicator,
  rotatedBox,
  circularProgressIndicator,
  clipOval,
  card,
  visibility,
  fittedBox,
  aspectRatio,
  placeholder,
  animatedContainer,
  animatedOpacity,
  animatedAlign,
  offStage,
  overflowbox,
  indexedStack,
  listTile,
  refreshIndicator,
  constrainedBox,
  expansionPanel,
  cupertinoSwitch,
  cupertinoPicker,
  cupertinoSegmentedControl,
  map,
  mapBuilder,
  mapBox,
  marker,
  tcard,
  tcardBuilder,
  concentricPageView,
  bouncingWidget,
  calendar,
  camera,
  audioPlayer,
  webview,
  parallax,
  dotsIndicator,
  wrapper,
  fontAwesome,

  // Transform
  transformRotate,
  transformTranslate,
  transformScale,
  transformPerspective,

  // Supabase
  supabaseFutureBuilder,
  supabaseStreamBuilder,
  supabaseLoggedUser,
  //Stripe
  stripeProductsBuilder,
  stripeCartItemsBuilder,

  // RevenueCat
  revenueCatProductsList,

  // HTTP Requests
  httpRequest,

  // TetaCMS
  cmsFetch,
  cmsStream,

  // AdMob
  adMobBanner,

  // Animations
  animationConfigList,
  animationConfigGrid,
  animationConfigStaticList,
  fadeInAnimation,
  slideAnimation,
  scaleAnimation,
}

extension NodeType on NType {
  ///Get node's type from NType enum value
  static String type(final NType type) => EnumToString.convertToString(type);

  ///Get node's display name from NType enum value
  static String name(final NType type) =>
      EnumToString.convertToString(type, camelCase: true);

  ///Get NType enum value from string
  static NType fromString(final String x) =>
      EnumToString.fromString(NType.values, x) ?? NType.nil;

  static NType fromStringCamelCase(final String x) =>
      EnumToString.fromString(NType.values, x, camelCase: true) ?? NType.nil;
}
