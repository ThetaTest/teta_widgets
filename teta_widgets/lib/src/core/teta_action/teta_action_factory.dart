import 'dart:core';

import 'package:collection/collection.dart';

import '../../elements/actions/actions_index.dart';
import '../../elements/actions/params_index.dart';
import 'index.dart';
import 'teta_action_legacy_adapter.dart';

class TetaActionFactory {
  TetaActionFactory._();

  static TetaAction? create({
    required final TetaActionType type,
    required final TetaActionParams? params,
    final TetaActionLoop? loop,
    final TetaActionCondition? condition,
    final int delay = 0,
  }) {
    switch (type) {
      case TetaActionType.alertShowSnackbar:
        return TAAlertSnackbar(
          params: params ?? const TAAlertSnackbarParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.airtableDelete:
        return TAAirtableDelete(
          params: params ?? const TAAirtableDeleteParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.airtableInsert:
        return TAAirtableInsert(
          params: params ?? const TAAirtableInsertParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.airtableUpdate:
        return TAAirtableUpdate(
          params: params ?? const TAAirtableUpdateParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerLoopOne:
        return TAAudioPlayerLoopOne(
          params: params ?? const TAAudioPlayerLoopOneParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerLoopAll:
        return TAAudioPlayerLoopAll(
          params: params ?? const TAAudioPlayerLoopAllParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerLoopOff:
        return TAAudioPlayerLoopOff(
          params: params ?? const TAAudioPlayerLoopOffParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerPause:
        return TAAudioPlayerPause(
          params: params ?? const TAAudioPlayerPauseParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerPlay:
        return TAAudioPlayerPlay(
          params: params ?? const TAAudioPlayerPlayParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerNextTrack:
        return TAAudioPlayerNextTrack(
          params: params ?? const TAAudioPlayerNextTrackParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerPreviousTrack:
        return TAAudioPlayerPreviousTrack(
          params: params ?? const TAAudioPlayerPreviousTrackParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.audioPlayerReload:
        return TAAudioPlayerReload(
          params: params ?? const TAAudioPlayerReloadParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.braintreeBuy:
        return TABraintreeBuy(
          params: params ?? const TABraintreeBuyParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraAlwaysFlash:
        return TACameraAlwaysFlash(
          params: params ?? const TACameraAlwaysFlashParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraAutoFlash:
        return TACameraAutoFlash(
          params: params ?? const TACameraAutoFlashParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraOffFlash:
        return TACameraOffFlash(
          params: params ?? const TACameraOffFlashParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraStartRecoring:
        return TACameraStartRecording(
          params: params ?? const TACameraStartRecordingParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraStopRecording:
        return TACameraStopRecording(
          params: params ?? const TACameraStopRecordingParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraSwitchCamera:
        return TACameraSwitchCamera(
          params: params ?? const TACameraSwitchCameraParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraTakePhoto:
        return TACameraTakePhoto(
          params: params ?? const TACameraTakePhotoParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.cameraTorchFlash:
        return TACameraTorchFlash(
          params: params ?? const TACameraTorchFlashParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.customFunction:
        return TACustomFunction(
          params: params ?? const TACustomFunctionParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.googleMapsReloadData:
        return TAGoogleMapsReloadData(
          params: params ?? const TAGoogleMapsReloadDataParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.googleMapsSetCameraPosition:
        return TAGoogleMapsSetCameraPosition(
          params: params ?? const TAGoogleMapsSetCameraPositionParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.googleMapsUpdateDeviceLiveLocation:
        return TAGoogleMapsUpdateLivePosition(
          params: params ?? const TAGoogleMapsUpdateLivePositionParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.customHttpDelete:
        return TACustomHttpRequestDelete(
          params: params ?? const TACustomHttpRequestDeleteParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.customHttpPost:
        return TACustomHttpRequestPost(
          params: params ?? const TACustomHttpRequestPostParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.customHttpUpdate:
        return TACustomHttpRequestUpdate(
          params: params ?? const TACustomHttpRequestUpdateParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.mixpanelTrack:
        return TAMixpanelTrack(
          params: params ?? const TAMixpanelTrackParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.mixpanelSetUserId:
        return TAMixpanelSetUserId(
          params: params ?? const TAMixpanelSetUserIdParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.apiCallsExecute:
        return TAApiCallsExecute(
          params: params ?? const TAApiCallsExecuteParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationGoBack:
        return TANavigationGoBack(
          params: params ?? const TANavigationGoBackParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationInAppReview:
        return TANavigationInAppReview(
          params: params ?? const TANavigationInAppReviewParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationLaunchUrl:
        return TANavigationLaunchUrl(
          params: params ?? const TANavigationLaunchUrlParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationOpenBottomSheet:
        return TANavigationOpenBottomSheet(
          params: params ?? const TANavigationOpenBottomSheetParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationOpenDatePicker:
        return TANavigationOpenDatePicker(
          params: params ?? const TANavigationOpenDatePickerParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationOpenDrawer:
        return TANavigationOpenDrawer(
          params: params ?? const TANavigationOpenDrawerParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationOpenPage:
        return TANavigationOpenPage(
          params: params ?? const TANavigationOpenPageParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationOpenSnackBar:
        return TANavigationOpenSnackBar(
          params: params ?? const TANavigationOpenSnackBarParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.navigationShare:
        return TANavigationShare(
          params: params ?? const TANavigationShareParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.qonversionBuy:
        return TAQonversionBuy(
          params: params ?? const TAQonversionBuyParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.qonversionRestore:
        return TAQonversionRestore(
          params: params ?? const TAQonversionRestoreParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.revenueCatBuy:
        return TARevenueCatBuy(
          params: params ?? const TARevenueCatBuyParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.revenueCatRestore:
        return TARevenueCatRestore(
          params: params ?? const TARevenueCatRestoreParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stateChangeWithParam:
        return TAStateChangeWithParam(
          params: params ?? const TAStateChangeWithParamParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stateChangeWith:
        return TAStateChangeWith(
          params: params ?? const TAStateChangeWithParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stateDecrement:
        return TAStateDecrement(
          params: params ?? const TAStateDecrementParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stateEmailValidator:
        return TAStateEmailValidator(
          params: params ?? TAStateEmailValidatorParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stateGetTimeNow:
        // TODO(gabfeudo): IMPLEMENT
        // return TAStateGetTimeNow.fromJson(json);
        break;

      case TetaActionType.stateIncrement:
        return TAStateIncrement(
          params: params ?? const TAStateIncrementParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.statePasswordValidator:
        return TAStatePasswordValidator(
          params: params ?? TAStatePasswordValidatorParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.statePhoneValidator:
        return TAStatePhoneValidator(
          params: params ?? TAStatePhoneValidatorParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.statePickFile:
        return TAStatePickFile(
          params: params ?? const TAStatePickFileParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stateWebsiteValidator:
        return TAStateWebsiteValidator(
          params: params ?? TAStateWebsiteValidatorParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stateUnfocus:
        return TAStateUnfocus(
          params: params ?? const TAStateUnfocusParams(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stripeCheckout:
        // TODO(gabfeudo): IMPLEMENT
        // return TAStripeCheckout.fromJson(json);
        break;

      case TetaActionType.stripeAddListItemToCart:
        return TAStripeAddProductsListItemToCart(
          params:
              params ?? const TAStripeAddProductsListItemToCartParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stripeCartBuyAll:
        return TAStripeBuyAllCart(
          params: params ?? const TAStripeBuyAllCartParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stripeCartRemoveListItem:
        return TAStripeRemoveProductsListItemFromCart(
          params: params ??
              const TAStripeRemoveProductsListItemFromCartParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.stripeShowReceipt:
        return TAStripeShowReceipt(
          params: params ?? const TAStripeShowReceiptParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseMessagingSubscribeToTopic:
        return TAFirebaseMessagingSubscribeTopic(
          params:
              params ?? const TAFirebaseMessagingSubscribeTopicParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseMessagingUnsubscribeFromTopic:
        return TAFirebaseMessagingUnsubscribeTopic(
          params:
              params ?? const TAFirebaseMessagingUnsubscribeTopicParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsLogAppOpen:
        return TAFirebaseAnalyticsLogAppOpen(
          params: params ?? const TAFirebaseAnalyticsLogAppOpenParams(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsLogEvent:
        return TAFirebaseAnalyticsLogEvent(
          params: params ?? const TAFirebaseAnalyticsLogEventParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsLogJoinGroup:
        return TAFirebaseAnalyticsLogJoinGroup(
          params: params ?? const TAFirebaseAnalyticsLogJoinGroupParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsLogLogin:
        return TAFirebaseAnalyticsLogLogin(
          params: params ?? const TAFirebaseAnalyticsLogLoginParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsLogScreenView:
        return TAFirebaseAnalyticsLogScreenView(
          params:
              params ?? const TAFirebaseAnalyticsLogScreenViewParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsLogShare:
        return TAFirebaseAnalyticsLogShare(
          params: params ?? const TAFirebaseAnalyticsLogShareParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsResetAnalyticsData:
        return TAFirebaseAnalyticsResetData(
          params: params ?? const TAFirebaseAnalyticsResetDataParams(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsSetCurrentScreen:
        return TAFirebaseAnalyticsSetCurrentScreen(
          params:
              params ?? const TAFirebaseAnalyticsSetCurrentScreenParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsSetUserId:
        return TAFirebaseAnalyticsSetUserId(
          params: params ?? const TAFirebaseAnalyticsSetUserIdParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.firebaseAnalyticsSetUserProperty:
        return TAFirebaseAnalyticsSetUserProperty(
          params:
              params ?? const TAFirebaseAnalyticsSetUserPropertyParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseDelete:
        return TASupabaseDelete(
          params: params ?? TASupabaseDeleteParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseInsert:
        return TASupabaseInsert(
          params: params ?? const TASupabaseInsertParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseFunctionInvoke:
        return TASupabaseFunctionInvoke(
          params: params ?? const TASupabaseFunctionInvokeParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseOnAll:
        return TASupabaseOnAll(
          params: params ?? const TASupabaseOnAllParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseOnDelete:
        return TASupabaseOnDelete(
          params: params ?? const TASupabaseOnDeleteParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseOnInsert:
        return TASupabaseOnInsert(
          params: params ?? const TASupabaseOnInsertParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseOnUpdate:
        return TASupabaseOnUpdate(
          params: params ?? const TASupabaseOnUpdateParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseSignInWithCredentials:
        return TASupabaseSignInWithCredentials(
          params: params ?? const TASupabaseSignInWithCredentialsParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseSignInWithProvider:
        return TASupabaseSignInWithProvider(
          params: params ?? const TASupabaseSignInWithProviderParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseSignUpWithCredentials:
        return TASupabaseSignUp(
          params: params ?? const TASupabaseSignUpParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseStorageDelete:
        return TASupabaseStorageDelete(
          params: params ?? const TASupabaseStorageDeleteParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseStorageUpload:
        return TASupabaseStorageUpload(
          params: params ?? const TASupabaseStorageUploadParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.supabaseUpdate:
        return TASupabaseUpdate(
          params: params ?? TASupabaseUpdateParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.tetaCmsAuthLogin:
        return TATetaCMSLogin(
          params: params ?? const TATetaCMSLoginParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.tetaCmsAuthLogout:
        return TATetaCMSLogout(
          params: params ?? const TATetaCMSLogoutParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.tetaCmsDbDelete:
        return TATetaCMSDelete(
          params: params ?? const TATetaCMSDeleteParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.tetaCmsDbInsert:
        return TATetaCMSInsert(
          params: params ?? const TATetaCMSInsertParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.tetaCmsDbUpdate:
        return TATetaCMSUpdate(
          params: params ?? const TATetaCMSUpdateParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.tetaCmsDbOnAll:
        return TATetaCMSOnAll(
          params: params ?? const TATetaCMSOnAllParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.tetaStoreCheckout:
        return TATetaStoreCheckout(
          params: params ?? const TATetaStoreCheckoutParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.themeChangeTheme:
        return TAChangeTheme(
          params: params ?? const TAChangeThemeParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.translatorTranslate:
        return TATranslatorTranslate(
          params: params ?? const TATranslatorTranslateParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.webViewGoBack:
        return TAWebViewGoBack(
          params: params ?? const TAWebViewGoBackParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.webViewGoForward:
        return TAWebViewGoForward(
          params: params ?? const TAWebViewGoForwardParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.webViewReload:
        return TAWebViewReload(
          params: params ?? const TAWebViewReloadParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );

      case TetaActionType.webViewNavigateTo:
        return TAWebViewNavigateTo(
          params: params ?? TAWebViewNavigateToParams.empty(),
          loop: loop,
          condition: condition,
          delay: delay,
        );
    }

    // Defaults to null
    return null;
  }

  static TetaAction? fromJson(
    final Map<String, dynamic> storedJson, {
    final bool legacyAction = false,
  }) {
    late final Map<String, dynamic> json;
    // Legacy support
    if (legacyAction) {
      json = TetaActionLegacyAdapter.convertLegacyJsonToNewJson(storedJson);
    } else {
      json = storedJson;
    }

    final type = TetaActionType.values.firstWhereOrNull(
      (final e) => e.toString() == json['type'],
    );

    switch (type) {
      case TetaActionType.alertShowSnackbar:
        return TAAlertSnackbar.fromJson(json);

      case TetaActionType.airtableDelete:
        return TAAirtableDelete.fromJson(json);

      case TetaActionType.airtableInsert:
        return TAAirtableInsert.fromJson(json);

      case TetaActionType.airtableUpdate:
        return TAAirtableUpdate.fromJson(json);

      case TetaActionType.audioPlayerLoopOne:
        return TAAudioPlayerLoopOne.fromJson(json);

      case TetaActionType.audioPlayerLoopAll:
        return TAAudioPlayerLoopAll.fromJson(json);

      case TetaActionType.audioPlayerLoopOff:
        return TAAudioPlayerLoopOff.fromJson(json);

      case TetaActionType.audioPlayerPause:
        return TAAudioPlayerPause.fromJson(json);

      case TetaActionType.audioPlayerPlay:
        return TAAudioPlayerPlay.fromJson(json);

      case TetaActionType.audioPlayerNextTrack:
        return TAAudioPlayerNextTrack.fromJson(json);

      case TetaActionType.audioPlayerPreviousTrack:
        return TAAudioPlayerPreviousTrack.fromJson(json);

      case TetaActionType.audioPlayerReload:
        return TAAudioPlayerReload.fromJson(json);

      case TetaActionType.braintreeBuy:
        return TABraintreeBuy.fromJson(json);

      case TetaActionType.cameraAlwaysFlash:
        return TACameraAlwaysFlash.fromJson(json);

      case TetaActionType.cameraAutoFlash:
        return TACameraAutoFlash.fromJson(json);

      case TetaActionType.cameraOffFlash:
        return TACameraOffFlash.fromJson(json);

      case TetaActionType.cameraStartRecoring:
        return TACameraStartRecording.fromJson(json);

      case TetaActionType.cameraStopRecording:
        return TACameraStopRecording.fromJson(json);

      case TetaActionType.cameraSwitchCamera:
        return TACameraSwitchCamera.fromJson(json);

      case TetaActionType.cameraTakePhoto:
        return TACameraTakePhoto.fromJson(json);

      case TetaActionType.cameraTorchFlash:
        return TACameraTorchFlash.fromJson(json);

      case TetaActionType.customFunction:
        return TACustomFunction.fromJson(json);

      case TetaActionType.googleMapsReloadData:
        return TAGoogleMapsReloadData.fromJson(json);

      case TetaActionType.googleMapsSetCameraPosition:
        return TAGoogleMapsSetCameraPosition.fromJson(json);

      case TetaActionType.googleMapsUpdateDeviceLiveLocation:
        return TAGoogleMapsUpdateLivePosition.fromJson(json);

      case TetaActionType.customHttpDelete:
        return TACustomHttpRequestDelete.fromJson(json);

      case TetaActionType.customHttpPost:
        return TACustomHttpRequestPost.fromJson(json);

      case TetaActionType.customHttpUpdate:
        return TACustomHttpRequestUpdate.fromJson(json);

      case TetaActionType.mixpanelTrack:
        return TAMixpanelTrack.fromJson(json);

      case TetaActionType.mixpanelSetUserId:
        return TAMixpanelSetUserId.fromJson(json);

      case TetaActionType.apiCallsExecute:
        return TAApiCallsExecute.fromJson(json);

      case TetaActionType.navigationGoBack:
        return TANavigationGoBack.fromJson(json);

      case TetaActionType.navigationInAppReview:
        return TANavigationInAppReview.fromJson(json);

      case TetaActionType.navigationLaunchUrl:
        return TANavigationLaunchUrl.fromJson(json);

      case TetaActionType.navigationOpenBottomSheet:
        return TANavigationOpenBottomSheet.fromJson(json);

      case TetaActionType.navigationOpenDatePicker:
        return TANavigationOpenDatePicker.fromJson(json);

      case TetaActionType.navigationOpenDrawer:
        return TANavigationOpenDrawer.fromJson(json);

      case TetaActionType.navigationOpenPage:
        return TANavigationOpenPage.fromJson(json);

      case TetaActionType.navigationOpenSnackBar:
        return TANavigationOpenSnackBar.fromJson(json);

      case TetaActionType.navigationShare:
        return TANavigationShare.fromJson(json);

      case TetaActionType.qonversionBuy:
        return TAQonversionBuy.fromJson(json);

      case TetaActionType.qonversionRestore:
        return TAQonversionRestore.fromJson(json);

      case TetaActionType.revenueCatBuy:
        return TARevenueCatBuy.fromJson(json);

      case TetaActionType.revenueCatRestore:
        return TARevenueCatRestore.fromJson(json);

      case TetaActionType.stateChangeWithParam:
        return TAStateChangeWithParam.fromJson(json);

      case TetaActionType.stateChangeWith:
        return TAStateChangeWith.fromJson(json);

      case TetaActionType.stateDecrement:
        return TAStateDecrement.fromJson(json);

      case TetaActionType.stateEmailValidator:
        return TAStateEmailValidator.fromJson(json);

      case TetaActionType.stateUnfocus:
        return TAStateUnfocus.fromJson(json);

      case TetaActionType.stateGetTimeNow:
        // TODO(gabfeudo): IMPLEMENT
        // return TAStateGetTimeNow.fromJson(json);
        break;

      case TetaActionType.stateIncrement:
        return TAStateIncrement.fromJson(json);

      case TetaActionType.statePasswordValidator:
        return TAStatePasswordValidator.fromJson(json);

      case TetaActionType.statePhoneValidator:
        return TAStatePhoneValidator.fromJson(json);

      case TetaActionType.statePickFile:
        return TAStatePickFile.fromJson(json);

      case TetaActionType.stateWebsiteValidator:
        return TAStateWebsiteValidator.fromJson(json);

      case TetaActionType.stripeCheckout:
        // TODO(gabfeudo): IMPLEMENT
        // return TAStripeCheckout.fromJson(json);
        break;

      case TetaActionType.stripeAddListItemToCart:
        return TAStripeAddProductsListItemToCart.fromJson(json);

      case TetaActionType.stripeCartBuyAll:
        return TAStripeBuyAllCart.fromJson(json);

      case TetaActionType.stripeCartRemoveListItem:
        return TAStripeRemoveProductsListItemFromCart.fromJson(json);

      case TetaActionType.stripeShowReceipt:
        return TAStripeShowReceipt.fromJson(json);

      case TetaActionType.firebaseMessagingSubscribeToTopic:
        return TAFirebaseMessagingSubscribeTopic.fromJson(json);

      case TetaActionType.firebaseMessagingUnsubscribeFromTopic:
        return TAFirebaseMessagingUnsubscribeTopic.fromJson(json);

      case TetaActionType.firebaseAnalyticsLogAppOpen:
        return TAFirebaseAnalyticsLogAppOpen.fromJson(json);

      case TetaActionType.firebaseAnalyticsLogEvent:
        return TAFirebaseAnalyticsLogEvent.fromJson(json);

      case TetaActionType.firebaseAnalyticsLogJoinGroup:
        return TAFirebaseAnalyticsLogJoinGroup.fromJson(json);

      case TetaActionType.firebaseAnalyticsLogLogin:
        return TAFirebaseAnalyticsLogLogin.fromJson(json);

      case TetaActionType.firebaseAnalyticsLogScreenView:
        return TAFirebaseAnalyticsLogScreenView.fromJson(json);

      case TetaActionType.firebaseAnalyticsLogShare:
        return TAFirebaseAnalyticsLogShare.fromJson(json);

      case TetaActionType.firebaseAnalyticsResetAnalyticsData:
        return TAFirebaseAnalyticsResetData.fromJson(json);

      case TetaActionType.firebaseAnalyticsSetCurrentScreen:
        return TAFirebaseAnalyticsSetCurrentScreen.fromJson(json);

      case TetaActionType.firebaseAnalyticsSetUserId:
        return TAFirebaseAnalyticsSetUserId.fromJson(json);

      case TetaActionType.firebaseAnalyticsSetUserProperty:
        return TAFirebaseAnalyticsSetUserProperty.fromJson(json);

      case TetaActionType.supabaseDelete:
        return TASupabaseDelete.fromJson(json);

      case TetaActionType.supabaseInsert:
        return TASupabaseInsert.fromJson(json);

      case TetaActionType.supabaseFunctionInvoke:
        return TASupabaseFunctionInvoke.fromJson(json);

      case TetaActionType.supabaseOnAll:
        return TASupabaseOnAll.fromJson(json);

      case TetaActionType.supabaseOnDelete:
        return TASupabaseOnDelete.fromJson(json);

      case TetaActionType.supabaseOnInsert:
        return TASupabaseOnInsert.fromJson(json);

      case TetaActionType.supabaseOnUpdate:
        return TASupabaseOnUpdate.fromJson(json);

      case TetaActionType.supabaseSignInWithCredentials:
        return TASupabaseSignInWithCredentials.fromJson(json);

      case TetaActionType.supabaseSignInWithProvider:
        return TASupabaseSignInWithProvider.fromJson(json);

      case TetaActionType.supabaseSignUpWithCredentials:
        return TASupabaseSignUp.fromJson(json);

      case TetaActionType.supabaseStorageDelete:
        return TASupabaseStorageDelete.fromJson(json);

      case TetaActionType.supabaseStorageUpload:
        return TASupabaseStorageUpload.fromJson(json);

      case TetaActionType.supabaseUpdate:
        return TASupabaseUpdate.fromJson(json);

      case TetaActionType.tetaCmsAuthLogin:
        return TATetaCMSLogin.fromJson(json);

      case TetaActionType.tetaCmsAuthLogout:
        return TATetaCMSLogout.fromJson(json);

      case TetaActionType.tetaCmsDbDelete:
        return TATetaCMSDelete.fromJson(json);

      case TetaActionType.tetaCmsDbInsert:
        return TATetaCMSInsert.fromJson(json);

      case TetaActionType.tetaCmsDbUpdate:
        return TATetaCMSUpdate.fromJson(json);

      case TetaActionType.tetaCmsDbOnAll:
        return TATetaCMSOnAll.fromJson(json);

      case TetaActionType.tetaStoreCheckout:
        return TATetaStoreCheckout.fromJson(json);

      case TetaActionType.themeChangeTheme:
        return TAChangeTheme.fromJson(json);

      case TetaActionType.translatorTranslate:
        return TATranslatorTranslate.fromJson(json);

      case TetaActionType.webViewGoBack:
        return TAWebViewGoBack.fromJson(json);

      case TetaActionType.webViewGoForward:
        return TAWebViewGoForward.fromJson(json);

      case TetaActionType.webViewReload:
        return TAWebViewReload.fromJson(json);

      case TetaActionType.webViewNavigateTo:
        return TAWebViewNavigateTo.fromJson(json);

      case null:
        return null;
    }

    // Defaults to null
    return null;
  }
}
