// Project imports:
import 'package:teta_widgets/src/elements/bodies/align.dart';
import 'package:teta_widgets/src/elements/bodies/animated_align.dart';
import 'package:teta_widgets/src/elements/bodies/animated_container.dart';
import 'package:teta_widgets/src/elements/bodies/animated_opacity.dart';
import 'package:teta_widgets/src/elements/bodies/animations/anim_config_grid.dart';
import 'package:teta_widgets/src/elements/bodies/animations/anim_config_list.dart';
import 'package:teta_widgets/src/elements/bodies/animations/fade_in.dart';
import 'package:teta_widgets/src/elements/bodies/animations/scale.dart';
import 'package:teta_widgets/src/elements/bodies/animations/slide.dart';
import 'package:teta_widgets/src/elements/bodies/aspect_ratio.dart';
import 'package:teta_widgets/src/elements/bodies/audio_player.dart';
import 'package:teta_widgets/src/elements/bodies/badge.dart';
import 'package:teta_widgets/src/elements/bodies/bottombaritem.dart';
import 'package:teta_widgets/src/elements/bodies/bouncing_widget.dart';
import 'package:teta_widgets/src/elements/bodies/button.dart';
import 'package:teta_widgets/src/elements/bodies/calendar.dart';
import 'package:teta_widgets/src/elements/bodies/camera.dart';
import 'package:teta_widgets/src/elements/bodies/card.dart';
import 'package:teta_widgets/src/elements/bodies/center.dart';
import 'package:teta_widgets/src/elements/bodies/checkbox.dart';
import 'package:teta_widgets/src/elements/bodies/circular_progress_indicator.dart';
import 'package:teta_widgets/src/elements/bodies/clip_oval.dart';
import 'package:teta_widgets/src/elements/bodies/clip_rect.dart';
import 'package:teta_widgets/src/elements/bodies/clip_rrect.dart';
import 'package:teta_widgets/src/elements/bodies/column.dart';
import 'package:teta_widgets/src/elements/bodies/component.dart';
import 'package:teta_widgets/src/elements/bodies/concentric_page_view.dart';
import 'package:teta_widgets/src/elements/bodies/condition.dart';
import 'package:teta_widgets/src/elements/bodies/constrained_box.dart';
import 'package:teta_widgets/src/elements/bodies/container.dart';
import 'package:teta_widgets/src/elements/bodies/cta/apple.dart';
import 'package:teta_widgets/src/elements/bodies/cta/facebook.dart';
import 'package:teta_widgets/src/elements/bodies/cta/github.dart';
import 'package:teta_widgets/src/elements/bodies/cta/google.dart';
import 'package:teta_widgets/src/elements/bodies/cta/twitter.dart';
import 'package:teta_widgets/src/elements/bodies/cupertino_appbar.dart';
import 'package:teta_widgets/src/elements/bodies/cupertino_picker.dart';
import 'package:teta_widgets/src/elements/bodies/cupertino_segmented_control.dart';
import 'package:teta_widgets/src/elements/bodies/cupertino_switch.dart';
import 'package:teta_widgets/src/elements/bodies/decoratedbox.dart';
import 'package:teta_widgets/src/elements/bodies/divider.dart';
import 'package:teta_widgets/src/elements/bodies/dots_indicator.dart';
import 'package:teta_widgets/src/elements/bodies/expanded.dart';
import 'package:teta_widgets/src/elements/bodies/firebase/future_builder.dart';
import 'package:teta_widgets/src/elements/bodies/firebase/is_authenticated.dart';
import 'package:teta_widgets/src/elements/bodies/firebase/pagination.dart';
import 'package:teta_widgets/src/elements/bodies/firebase/stream_builder.dart';
import 'package:teta_widgets/src/elements/bodies/fitted_box.dart';
import 'package:teta_widgets/src/elements/bodies/gesture_detector.dart';
import 'package:teta_widgets/src/elements/bodies/gridview.dart';
import 'package:teta_widgets/src/elements/bodies/gridview_builder.dart';
import 'package:teta_widgets/src/elements/bodies/hero.dart';
import 'package:teta_widgets/src/elements/bodies/https_requests/future_builder.dart';
import 'package:teta_widgets/src/elements/bodies/icon.dart';
import 'package:teta_widgets/src/elements/bodies/ignore_pointer.dart';
import 'package:teta_widgets/src/elements/bodies/image.dart';
import 'package:teta_widgets/src/elements/bodies/index_stack.dart';
import 'package:teta_widgets/src/elements/bodies/linear_progress_indicator.dart';
import 'package:teta_widgets/src/elements/bodies/liquid_swipe.dart';
import 'package:teta_widgets/src/elements/bodies/list_tile.dart';
import 'package:teta_widgets/src/elements/bodies/listview.dart';
import 'package:teta_widgets/src/elements/bodies/listview_builder.dart';
import 'package:teta_widgets/src/elements/bodies/lottie.dart';
import 'package:teta_widgets/src/elements/bodies/map.dart';
import 'package:teta_widgets/src/elements/bodies/map_builder.dart';
import 'package:teta_widgets/src/elements/bodies/marker.dart';
import 'package:teta_widgets/src/elements/bodies/material_appbar.dart';
import 'package:teta_widgets/src/elements/bodies/material_bottombar.dart';
import 'package:teta_widgets/src/elements/bodies/navigation/appbar.dart';
import 'package:teta_widgets/src/elements/bodies/navigation/bottombar.dart';
import 'package:teta_widgets/src/elements/bodies/navigation/drawer.dart';
import 'package:teta_widgets/src/elements/bodies/off_stage.dart';
import 'package:teta_widgets/src/elements/bodies/opacity.dart';
import 'package:teta_widgets/src/elements/bodies/outlinedbutton.dart';
import 'package:teta_widgets/src/elements/bodies/overflowbox.dart';
import 'package:teta_widgets/src/elements/bodies/padding.dart';
import 'package:teta_widgets/src/elements/bodies/page_view.dart';
import 'package:teta_widgets/src/elements/bodies/parallax.dart';
import 'package:teta_widgets/src/elements/bodies/placeholder.dart';
import 'package:teta_widgets/src/elements/bodies/positioned.dart';
import 'package:teta_widgets/src/elements/bodies/radio.dart';
import 'package:teta_widgets/src/elements/bodies/refresh_indicator.dart';
import 'package:teta_widgets/src/elements/bodies/responsive/wrapper.dart';
import 'package:teta_widgets/src/elements/bodies/responsive_condition.dart';
import 'package:teta_widgets/src/elements/bodies/revenuecat/revenuecat_product_list_body.dart';
import 'package:teta_widgets/src/elements/bodies/rotatedbox.dart';
import 'package:teta_widgets/src/elements/bodies/row.dart';
import 'package:teta_widgets/src/elements/bodies/safearea.dart';
import 'package:teta_widgets/src/elements/bodies/scaffold.dart';
import 'package:teta_widgets/src/elements/bodies/sizedbox.dart';
import 'package:teta_widgets/src/elements/bodies/spacer.dart';
import 'package:teta_widgets/src/elements/bodies/stack.dart';
import 'package:teta_widgets/src/elements/bodies/stripe_products_builder.dart';
import 'package:teta_widgets/src/elements/bodies/supabase/future_builder.dart';
import 'package:teta_widgets/src/elements/bodies/supabase/future_stream_builder.dart';
import 'package:teta_widgets/src/elements/bodies/supabase/logged_user.dart';
import 'package:teta_widgets/src/elements/bodies/tcard.dart';
import 'package:teta_widgets/src/elements/bodies/tcard_builder.dart';
import 'package:teta_widgets/src/elements/bodies/teta_cms/fetch.dart';
import 'package:teta_widgets/src/elements/bodies/teta_cms/stream.dart';
import 'package:teta_widgets/src/elements/bodies/text.dart';
import 'package:teta_widgets/src/elements/bodies/textbutton.dart';
import 'package:teta_widgets/src/elements/bodies/textfield.dart';
import 'package:teta_widgets/src/elements/bodies/tooltip.dart';
import 'package:teta_widgets/src/elements/bodies/transform.dart';
import 'package:teta_widgets/src/elements/bodies/video.dart';
import 'package:teta_widgets/src/elements/bodies/visibility.dart';
import 'package:teta_widgets/src/elements/bodies/webview.dart';
import 'package:teta_widgets/src/elements/bodies/wordpress/example.dart';
import 'package:teta_widgets/src/elements/bodies/wrap.dart';
import 'package:teta_widgets/src/elements/google_ad_mob_banner_ad_body.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

import 'bodies/stripe_cart_items_builder_body.dart';

/// The list of the all instrict states
final stateTypes = <IntrinsicStates>[
  alignIntrinsicStates,
  badgeIntrinsicStates,
  buttonIntrinsicStates,
  centerIntrinsicStates,
  checkBoxIntrinsicStates,
  columnIntrinsicStates,
  componentIntrinsicStates,
  conditionIntrinsicStates,
  containerIntrinsicStates,
  decoratedBoxIntrinsicStates,
  dividerIntrinsicStates,
  expandedIntrinsicStates,
  gestureDetectorIntrinsicStates,
  gridIntrinsicStates,
  gridViewBuilderIntrinsicStates,
  heroIntrinsicStates,
  iconIntrinsicStates,
  ignorePointIntrinsicStates,
  imageIntrinsicStates,
  liquidSwipeIntrinsicStates,
  listIntrinsicStates,
  lottieIntrinsicStates,
  opacityIntrinsicStates,
  outlinedButtonIntrinsicStates,
  paddingIntrinsicStates,
  pageViewIntrinsicStates,
  positionedIntrinsicStates,
  responsiveIntrinsicStates,
  rowIntrinsicStates,
  safeareaIntrinsicStates,
  scaffoldIntrinsicStates,
  sizedBoxIntrinsicStates,
  spacerIntrinsicStates,
  stackIntrinsicStates,
  textIntrinsicStates,
  googleAdMobBannerAdIntrinsicStates,
  textButtonIntrinsicStates,
  textFieldIntrinsicStates,
  videoIntrinsicStates,
  wrapIntrinsicStates,
  appBarIntrinsicStates,
  bottomBarIntrinsicStates,
  drawerIntrinsicStates,
  firebaseFutureBuilderIntrinsicStates,
  firebaseStreamBuilderIntrinsicStates,
  firebasePaginationIntrinsicStates,
  loginTwitterIntrinsicStates,
  loginAppleIntrinsicStates,
  loginGoogleIntrinsicStates,
  loginFacebookIntrinsicStates,
  loginGitHubIntrinsicStates,
  firebaseIsAuthenticatedIntrinsicStates,
  wpExampleIntrinsicStates,
  radioIntrinsicStates,
  tooltipIntrinsicStates,
  materialAppBarIntrinsicStates,
  cupertinoAppBarIntrinsicStates,
  materialBottomBarIntrinsicStates,
  bottombaritemIntrinsicStates,
  supabaseFutureBuilderIntrinsicStates,
  supabaseStreamBuilderIntrinsicStates,
  clipRectIntrinsicStates,
  linearProgressIndicatorIntrinsicStates,
  clipOvalIntrinsicStates,
  cardIntrinsicStates,
  visibilityIntrinsicStates,
  aspectRatioIntrinsicStates,
  placeholderIntrinsicStates,
  animatedContainerIntrinsicStates,
  animatedOpacityIntrinsicStates,
  animatedAlignIntrinsicStates,
  offStageIntrinsicStates,
  rotatedBoxIntrinsicStates,
  circularProgressIndicatorIntrinsicStates,
  listViewBuilderIntrinsicStates,
  clipRRectIntrinsicStates,
  overFlowBoxIntrinsicStates,
  indexedStackIntrinsicStates,
  refreshIndicatorIntrinsicStates,
  constrainedBoxIntrinsicStates,
  listTileIntrinsicStates,
  cupertinoSwitchIntrinsicStates,
  fittedBoxIntrinsicStates,
  mapIntrinsicStates,
  markerIntrinsicStates,
  tcardIntrinsicStates,
  tcardBuilderIntrinsicStates,
  concentricPageViewIntrinsicStates,
  bouncingWidgetIntrinsicStates,
  calendarIntrinsicStates,
  cameraIntrinsicStates,
  webviewIntrinsicStates,
  audioPlayerIntrinsicStates,
  supabaseLoggedUserIntrinsicStates,
  httpRequestFutureBuilderIntrinsicStates,
  cupertinoSegmentedControlIntrinsicStates,
  cupertinoPickerIntrinsicStates,
  parallaxIntrinsicStates,
  dotsIndicatorIntrinsicStates,
  mapBuilderIntrinsicStates,
  wrapperIntrinsicStates,
  revenueCatProductsListIntrinsicStates,
  stripeProductsBuilder,
  stripeCartItemsBuilderBodyIntrinsicStates,
  transformPerspectiveIntrinsicStates,
  cmsFetchIntrinsicStates,
  cmsStreamIntrinsicStates,
  animationConfigListIntrinsicStates,
  animationConfigGridIntrinsicStates,
  fadeInAnimationIntrinsicStates,
  scaleAnimationIntrinsicStates,
  slideAnimationIntrinsicStates,
];

/// Method to return any body
NodeBody getBody(final NType type) {
  switch (type) {
    case NType.align:
      return AlignBody();
    case NType.appBar:
      return AppBarBody();
    case NType.badge:
      return BadgeBody();
    case NType.revenueCatProductsList:
      return RevenueCatProductListBody();
    case NType.bottomBar:
      return BottomBarBody();
    case NType.button:
      return ButtonBody();
    case NType.center:
      return CenterBody();
    case NType.checkbox:
      return CheckBoxBody();
    case NType.stripeProductsBuilder:
      return StripeProductsBuilderBody();
    case NType.stripeCartItemsBuilder:
      return StripeCartItemsBuilderBody();
    case NType.column:
      return ColumnBody();
    case NType.component:
      return ComponentBody();
    case NType.condition:
      return ConditionBody();
    case NType.container:
      return ContainerBody();
    case NType.decoratedBox:
      return DecoratedBoxBody();
    case NType.divider:
      return DividerBody();
    case NType.drawer:
      return DrawerBody();
    case NType.expanded:
      return ExpandedBody();
    case NType.firebaseFutureBuilder:
      return FirebaseFBBody();
    case NType.firebasePagination:
      return FirebasePaginationBody();
    case NType.firebaseStreamBuilder:
      return FirebaseSBBody();
    case NType.gestureDetector:
      return GestureDetectorBody();
    case NType.gridView:
      return GridViewBody();
    case NType.gridViewBuilder:
      return GridViewBuilderBody();
    case NType.hero:
      return HeroBody();
    case NType.icon:
      return IconBody();
    case NType.ignorePointer:
      return IgnorePointerBody();
    case NType.image:
      return ImageBody();
    case NType.liquidSwipe:
      return LiquidSwipeBody();
    case NType.listView:
      return ListViewBody();
    case NType.loginWithApple:
      return LoginWithAppleBody();
    case NType.loginWithFacebook:
      return LoginWithFacebookBody();
    case NType.loginWithGitHub:
      return LoginWithGitHubBody();
    case NType.loginWithGoogle:
      return LoginWithGoogleBody();
    case NType.loginWithTwitter:
      return LoginWithTwitterBody();
    case NType.lottie:
      return LottieBody();
    case NType.opacity:
      return OpacityBody();
    case NType.outlinedButton:
      return OutlinedButtonBody();
    case NType.padding:
      return PaddingBody();
    case NType.pageView:
      return PageViewBody();
    case NType.positioned:
      return PositionedBody();
    case NType.responsiveCondition:
      return ResponsiveBody();
    case NType.row:
      return RowBody();
    case NType.safeArea:
      return SafeAreaBody();
    case NType.scaffold:
      return ScaffoldBody();
    case NType.sizedBox:
      return SizedBoxBody();
    case NType.spacer:
      return SpacerBody();
    case NType.stack:
      return StackBody();
    case NType.text:
      return TextBody();
    case NType.adMobBannerAd:
      return GoogleAdMobBannerAdBody();
    case NType.textButton:
      return TextButtonBody();
    case NType.textField:
      return TextFieldBody();
    case NType.video:
      return VideoBody();
    case NType.wrap:
      return WrapBody();
    case NType.firebaseIsAuthenticated:
      return FirebaseIsAuthenticatedBody();
    case NType.exampleWP:
      return WPExampleBody();
    case NType.radio:
      return RadioBody();
    case NType.tooltip:
      return TooltipBody();
    case NType.materialAppBar:
      return MaterialAppBarBody();
    case NType.cupertinoAppBar:
      return CupertinoAppBarBody();
    case NType.materialBottomBar:
      return MaterialBottomBarBody();
    case NType.bottombaritem:
      return BottomBarItemBody();
    case NType.supabaseFutureBuilder:
      return SupabaseFutureBuilderBody();
    case NType.supabaseStreamBuilder:
      return SupabaseStreamBuilderBody();
    case NType.clipRect:
      return SupabaseStreamBuilderBody();
    case NType.linearProgressIndicator:
      return LinearProgressIndicatorBody();
    case NType.circularProgressIndicator:
      return CircularProgressIndicatorBody();
    case NType.rotatedBox:
      return RotatedBoxBody();
    case NType.clipOval:
      return ClipOvalBody();
    case NType.card:
      return CardBody();
    case NType.visibility:
      return VisibilityBody();
    case NType.aspectRatio:
      return AspectRatioBody();
    case NType.placeholder:
      return PlaceholderBody();
    case NType.animatedContainer:
      return AnimatedContainerBody();
    case NType.animatedOpacity:
      return AnimatedOpacityBody();
    case NType.animatedAlign:
      return AnimatedAlignBody();
    case NType.offStage:
      return OffStageBody();
    case NType.listViewBuilder:
      return ListViewBuilderBody();
    case NType.clipRoundedRect:
      return ClipRRectBody();
    case NType.overflowbox:
      return OverFlowBoxBody();
    case NType.indexedStack:
      return IndexedStackBody();
    case NType.refreshIndicator:
      return RefreshIndicatorBody();
    case NType.constrainedBox:
      return ConstrainedBoxBody();
    case NType.listTile:
      return ListTileBody();
    case NType.cupertinoSwitch:
      return CupertinoSwitchBody();
    case NType.map:
      return MapBody();
    case NType.mapBuilder:
      return MapBuilderBody();
    case NType.marker:
      return MarkerBody();
    case NType.tcard:
      return TCardBody();
    case NType.tcardBuilder:
      return TCardBuilderBody();
    case NType.concentricPageView:
      return ConcentricPageViewBody();
    case NType.bouncingWidget:
      return BouncingWidgetBody();
    case NType.calendar:
      return CalendarBody();
    case NType.camera:
      return CameraBody();
    case NType.webview:
      return WebViewBody();
    case NType.audioPlayer:
      return AudioPlayerBody();
    case NType.supabaseLoggedUser:
      return SupabaseLoggedUserBody();
    case NType.httpRequest:
      return HTTPRequestFutureBuilderBody();
    case NType.fittedBox:
      return FittedBoxBody();
    case NType.cupertinoSegmentedControl:
      return CupertinoSegmentedControlBody();
    case NType.cupertinoPicker:
      return CupertinoPickerBody();
    case NType.parallax:
      return ParallaxBoxBody();
    case NType.dotsIndicator:
      return DotsIndicatorBody();
    case NType.wrapper:
      return WrapperBody();
    case NType.transformPerspective:
      return TransformPerspectiveBody();
    case NType.cmsFetch:
      return CmsFetchBody();
    case NType.cmsStream:
      return CmsStreamBody();
    case NType.animationConfigList:
      return AnimationConfigListBody();
    case NType.animationConfigGrid:
      return AnimationConfigGridBody();
    case NType.fadeInAnimation:
      return FadeInAnimationBody();
    case NType.scaleAnimation:
      return ScaleAnimationBody();
    case NType.slideAnimation:
      return SlideAnimationBody();
    case NType.listViewSeparated:
      break;
    case NType.nil:
      break;
    case NType.expansionPanel:
      break;
  }
  return NodeBody();
}
