// ignore_for_file: public_member_api_docs, must_be_immutable, avoid_bool_literals_in_conditional_expressions

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/src/services/packages_service.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/airtable/delete.dart';
import 'package:teta_widgets/src/elements/actions/airtable/insert.dart';
import 'package:teta_widgets/src/elements/actions/airtable/update.dart';
import 'package:teta_widgets/src/elements/actions/api_calls/apicalls.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/loop_all.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/loop_off.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/loop_one.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/pause.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/play.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/player_next_track.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/player_previous_track.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/reload.dart';
import 'package:teta_widgets/src/elements/actions/braintree/pay.dart';
import 'package:teta_widgets/src/elements/actions/camera/always_flash.dart';
import 'package:teta_widgets/src/elements/actions/camera/auto_flash.dart';
import 'package:teta_widgets/src/elements/actions/camera/off_flash.dart';
import 'package:teta_widgets/src/elements/actions/camera/stop_recording.dart';
import 'package:teta_widgets/src/elements/actions/camera/switch_camera.dart';
import 'package:teta_widgets/src/elements/actions/camera/take_photo.dart';
import 'package:teta_widgets/src/elements/actions/camera/torch_flash.dart';
import 'package:teta_widgets/src/elements/actions/custom_functions/custom_function.dart';
import 'package:teta_widgets/src/elements/actions/delay.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/log_app_open.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/log_event.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/log_join_group.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/log_login.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/log_share.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/reset_analytics_data.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/set_current_screen.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/set_user_id.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_analytics/set_user_property.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_message/subscribe_to_topic.dart';
import 'package:teta_widgets/src/elements/actions/firebase/firebase_message/unsubscribe_from_topic.dart';
import 'package:teta_widgets/src/elements/actions/google_maps/reload_data.dart';
import 'package:teta_widgets/src/elements/actions/google_maps/set_camera_position.dart';
import 'package:teta_widgets/src/elements/actions/google_maps/update_device_live_location.dart';
import 'package:teta_widgets/src/elements/actions/https_requests_custom_backend/delete.dart';
import 'package:teta_widgets/src/elements/actions/https_requests_custom_backend/post.dart';
import 'package:teta_widgets/src/elements/actions/https_requests_custom_backend/update.dart';
import 'package:teta_widgets/src/elements/actions/loop.dart';
import 'package:teta_widgets/src/elements/actions/mixpanel/set_user_id.dart';
import 'package:teta_widgets/src/elements/actions/mixpanel/track.dart';
import 'package:teta_widgets/src/elements/actions/navigation/go_back.dart';
import 'package:teta_widgets/src/elements/actions/navigation/in_app_review.dart';
import 'package:teta_widgets/src/elements/actions/navigation/launch_url.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_bottom_sheet.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_date_picker.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_drawer.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_snack.dart';
import 'package:teta_widgets/src/elements/actions/navigation/share.dart';
import 'package:teta_widgets/src/elements/actions/qonversion/buy.dart';
import 'package:teta_widgets/src/elements/actions/qonversion/restore.dart';
import 'package:teta_widgets/src/elements/actions/revenue_cat/buy.dart';
import 'package:teta_widgets/src/elements/actions/revenue_cat/restore.dart';
import 'package:teta_widgets/src/elements/actions/state/change_with.dart';
import 'package:teta_widgets/src/elements/actions/state/change_with_param.dart';
import 'package:teta_widgets/src/elements/actions/state/decrement.dart';
import 'package:teta_widgets/src/elements/actions/state/email_validator.dart';
import 'package:teta_widgets/src/elements/actions/state/increment.dart';
import 'package:teta_widgets/src/elements/actions/state/password_validator.dart';
import 'package:teta_widgets/src/elements/actions/state/phone_validator.dart';
import 'package:teta_widgets/src/elements/actions/state/pick_file.dart';
import 'package:teta_widgets/src/elements/actions/state/website_validator.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_add_list_item_to_cart.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_cart_buy_all.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_cart_remove_list_item_from_cart.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_show_receipt.dart';
import 'package:teta_widgets/src/elements/actions/supabase/delete.dart';
import 'package:teta_widgets/src/elements/actions/supabase/function_invoke.dart';
import 'package:teta_widgets/src/elements/actions/supabase/insert.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_credentials.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_provider.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signup_w_credentials.dart';
import 'package:teta_widgets/src/elements/actions/supabase/storage_delete.dart';
import 'package:teta_widgets/src/elements/actions/supabase/storage_upload.dart';
import 'package:teta_widgets/src/elements/actions/supabase/update.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/auth/login.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/auth/logout.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/database/delete.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/database/insert.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/database/update.dart';
import 'package:teta_widgets/src/elements/actions/theme/change_theme.dart';
import 'package:teta_widgets/src/elements/actions/translator/translate.dart';
import 'package:teta_widgets/src/elements/actions/webview/back.dart';
import 'package:teta_widgets/src/elements/actions/webview/forward.dart';
import 'package:teta_widgets/src/elements/actions/webview/navigate_to.dart';
import 'package:teta_widgets/src/elements/actions/webview/reload.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/action_google_maps.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/airtable.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/apicalls.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/audio_player_actions.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/braintree.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/camera.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/custom_http_request.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/firebase/firebase_message.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/mixpanel.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/qonversion.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/revenue_cat.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/stripe.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/teta_cms.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/theme.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/translator.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/webview.dart';
import 'package:teta_widgets/src/elements/features/actions/snippets.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:uuid/uuid.dart';

import '../../actions/firebase/firebase_analytics/log_screen_view.dart';
import 'enums/firebase/firebase_analytics.dart';

class FActionElement extends Equatable {
  FActionElement({
    this.id,
    this.actionRevenueCat,
    this.actionQonversion,
    this.actionMixpanel,
    this.actionTheme,
    this.actionStripe,
    this.actionGoogleMaps,
    this.actionType,
    this.actionGesture,
    this.actionNavigation,
    this.actionState,
    this.customFunctionId,
    this.actionSupabaseAuth,
    this.actionSupabaseDB,
    this.actionAirtableDB,
    this.actionSupabaseFunctions,
    this.actionSupabaseStorage,
    this.actionTetaDB,
    this.actionTetaAuth,
    this.actionCustomHttpRequest,
    this.actionApiCalls,
    this.actionCamera,
    this.actionWebView,
    this.actionAudioPlayer,
    this.actionTranslator,
    this.actionFirebaseAnalytics,
    this.actionFirebaseMessages,
    this.prodId,
    this.stateName,
    this.stateName2,
    this.stateName3,
    this.stateName4,
    this.nameOfPage,
    this.paramsToSend,
    this.value,
    this.delay,
    this.audioPlayerUrl,
    this.dbFrom,
    this.cmsCollectionId,
    this.dbData,
    this.dbEq,
    this.withCondition,
    this.condition,
    this.valueOfCondition,
    this.withLoop,
    this.everyMilliseconds,
    this.valueTextTypeInput,
    this.customHttpRequestURL,
    this.customHttpRequestExpectedStatusCode,
    this.customHttpRequestHeader,
    this.customHttpRequestList,
    this.customHttpRequestBody,
    this.apiCallsRequestName,
    this.apiCallsSelectedRequest,
    this.apiCallsResponseName,
    this.apiCallsDynamicValue,
    this.firebaseAnalyticsLoginMethod,
    this.firebaseAnalyticsParameters,
    this.firebaseAnalyticsName,
    this.firebaseAnalyticsGroupId,
    this.firebaseAnalyticsScreenName,
    this.firebaseAnalyticsContentType,
    this.firebaseAnalyticsItemId,
    this.firebaseAnalyticsMethod,
    this.firebaseAnalyticsUserId,
    this.firebaseAnalyticsValue,
    this.firebaseMessagesTopic,
  }) {
    id ??= const Uuid().v1();
    delay ??= FTextTypeInput(value: '0');
    audioPlayerUrl ??= FTextTypeInput(value: 'no_url');
    withLoop ??= false;
    everyMilliseconds ??= FTextTypeInput(value: '0');
    withCondition ??= false;
    condition ??= FTextTypeInput(value: '0');
    valueOfCondition ??= FTextTypeInput(value: '0');
  }

  FActionElement.fromJson(final Map<String, dynamic> doc) {
    id = doc['id'] as String?;
    actionType = convertDropdownToValue(ActionType.values, doc['aT'] as String?)
        as ActionType?;
    actionNavigation =
        convertDropdownToValue(ActionNavigation.values, doc['aN'] as String?)
            as ActionNavigation?;
    customFunctionId = doc['cFid'] as int?;
    actionBraintree = convertDropdownToValue(
      ActionBraintree.values,
      doc['aBrain'] as String?,
    ) as ActionBraintree?;
    actionTranslator = convertDropdownToValue(
      ActionTranslator.values,
      doc['aTrans'] as String?,
    ) as ActionTranslator?;
    actionRevenueCat =
        convertDropdownToValue(ActionRevenueCat.values, doc['aRC'] as String?)
            as ActionRevenueCat?;
    actionFirebaseAnalytics = convertDropdownToValue(
      ActionFirebaseAnalytics.values,
      doc['aFirebaseAnalytics'] as String?,
    ) as ActionFirebaseAnalytics?;
    actionFirebaseMessages = convertDropdownToValue(
            ActionFirebaseMessages.values, doc['aFirebaseMessages'] as String?)
        as ActionFirebaseMessages?;
    actionQonversion = convertDropdownToValue(
      ActionQonversion.values,
      doc['aQonversion'] as String?,
    ) as ActionQonversion?;
    actionMixpanel = convertDropdownToValue(
      ActionMixpanel.values,
      doc['aMixpanel'] as String?,
    ) as ActionMixpanel?;
    actionTheme =
        convertDropdownToValue(ActionTheme.values, doc['aTh'] as String?)
            as ActionTheme?;
    actionStripe =
        convertDropdownToValue(ActionStripe.values, doc['sPK'] as String?)
            as ActionStripe?;
    actionGoogleMaps = convertDropdownToValue(
      ActionGoogleMaps.values,
      doc['actionGoogleMaps'] as String?,
    ) as ActionGoogleMaps?;
    actionState =
        convertDropdownToValue(ActionState.values, doc['aS'] as String?)
            as ActionState?;
    actionGesture =
        convertDropdownToValue(ActionGesture.values, doc['g'] as String?)
            as ActionGesture?;
    actionSupabaseAuth =
        convertDropdownToValue(ActionSupabaseAuth.values, doc['sA'] as String?)
            as ActionSupabaseAuth?;
    actionSupabaseDB =
        convertDropdownToValue(ActionSupabaseDB.values, doc['sD'] as String?)
            as ActionSupabaseDB?;
    actionAirtableDB =
        convertDropdownToValue(ActionAirtableDB.values, doc['aD'] as String?)
            as ActionAirtableDB?;
    actionSupabaseFunctions = convertDropdownToValue(
      ActionSupabaseFunctions.values,
      doc['supaFuncs'] as String?,
    ) as ActionSupabaseFunctions?;
    actionSupabaseStorage = convertDropdownToValue(
      ActionSupabaseStorage.values,
      doc['supaStor'] as String?,
    ) as ActionSupabaseStorage?;
    actionCamera =
        convertDropdownToValue(ActionCamera.values, doc['aC'] as String?)
            as ActionCamera?;
    actionWebView =
        convertDropdownToValue(ActionWebView.values, doc['aW'] as String?)
            as ActionWebView?;
    actionAudioPlayer = convertDropdownToValue(
      ActionAudioPlayerActions.values,
      doc['aAP'] as String?,
    ) as ActionAudioPlayerActions?;
    actionTetaDB =
        convertDropdownToValue(ActionTetaCmsDB.values, doc['aTDb'] as String?)
            as ActionTetaCmsDB?;
    actionTetaAuth =
        convertDropdownToValue(ActionTetaCmsAuth.values, doc['aTAu'] as String?)
            as ActionTetaCmsAuth?;
    actionCustomHttpRequest = convertDropdownToValue(
      ActionCustomHttpRequest.values,
      doc['aCHr'] as String?,
    ) as ActionCustomHttpRequest?;
    actionApiCalls =
        convertDropdownToValue(ActionApiCalls.values, doc['aAC'] as String?)
            as ActionApiCalls?;
    stateName = doc['sN'] as String?;
    stateName2 = doc['sN2'] as String?;
    stateName3 = doc['sN3'] as String?;
    stateName4 = doc['sN4'] as String?;
    nameOfPage = doc['pN'] as String?;
    paramsToSend = doc['pTS'] as Map<String, dynamic>?;
    valueTextTypeInput =
        doc['v'] != null ? FTextTypeInput(value: doc['v'] as String?) : null;
    valueTextTypeInput = valueTextTypeInput ??
        (doc['vTTI'] != null
            ? FTextTypeInput.fromJson(doc['vTTI'] as Map<String, dynamic>)
            : FTextTypeInput());
    //email, phone, city, state, line1, postalCode, country
    stripeBillingInfoEmail = stripeBillingInfoEmail ??
        (doc['stripeBillingInfoEmail'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeBillingInfoEmail'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripePaymentIntentId = stripePaymentIntentId ??
        (doc['stripePaymentIntentId'] != null
            ? FTextTypeInput.fromJson(
                doc['stripePaymentIntentId'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripeBillingInfoPhone = stripeBillingInfoPhone ??
        (doc['stripeBillingInfoPhone'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeBillingInfoPhone'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripeBillingInfoCity = stripeBillingInfoCity ??
        (doc['stripeBillingInfoCity'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeBillingInfoCity'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripeBillingInfoState = stripeBillingInfoState ??
        (doc['stripeBillingInfoState'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeBillingInfoState'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripeBillingInfoLine = stripeBillingInfoLine ??
        (doc['stripeBillingInfoLine'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeBillingInfoLine'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripeBillingInfoPostalCode = stripeBillingInfoPostalCode ??
        (doc['stripeBillingInfoPostalCode'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeBillingInfoPostalCode'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripeBillingInfoCountry = stripeBillingInfoCountry ??
        (doc['stripeBillingInfoCountry'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeBillingInfoCountry'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    stripeShippingId = stripeShippingId ??
        (doc['stripeShippingId'] != null
            ? FTextTypeInput.fromJson(
                doc['stripeShippingId'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    // lat, lng, zoom
    googleMapsLat = googleMapsLat ??
        (doc['googleMapsLat'] != null
            ? FTextTypeInput.fromJson(
                doc['googleMapsLat'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    googleMapsLng = googleMapsLng ??
        (doc['googleMapsLng'] != null
            ? FTextTypeInput.fromJson(
                doc['googleMapsLng'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    googleMapsZoom = googleMapsZoom ??
        (doc['googleMapsZoom'] != null
            ? FTextTypeInput.fromJson(
                doc['googleMapsZoom'] as Map<String, dynamic>,
              )
            : FTextTypeInput());
    //
    dbFrom = FTextTypeInput.fromJson(doc['sFrom'] as Map<String, dynamic>?);
    cmsCollectionId = doc['cmsCId'] as String?;
    dbData = (doc['sData'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (final dynamic e) => MapElement.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
    dbEq = doc['sEq'] != null
        ? MapElement.fromJson(doc['sEq'] as Map<String, dynamic>)
        : MapElement(
            key: '',
            value: FTextTypeInput(),
          );
    delay = doc['delay'] != null
        ? FTextTypeInput.fromJson(doc['delay'] as Map<String, dynamic>)
        : FTextTypeInput(value: '0');
    audioPlayerUrl = doc['audioPlayerUrl'] != null
        ? FTextTypeInput.fromJson(doc['audioPlayerUrl'] as Map<String, dynamic>)
        : FTextTypeInput(value: 'no_url');
    withCondition =
        doc['wCond'] != null ? doc['wCond'] as bool? ?? false : false;
    condition = doc['cond'] != null
        ? FTextTypeInput.fromJson(doc['cond'] as Map<String, dynamic>)
        : FTextTypeInput();
    valueOfCondition = doc['vCond'] != null
        ? FTextTypeInput.fromJson(doc['vCond'] as Map<String, dynamic>)
        : FTextTypeInput();
    withLoop = doc['wLoop'] != null ? doc['wLoop'] as bool? ?? false : false;
    everyMilliseconds = doc['evrMll'] != null
        ? FTextTypeInput.fromJson(doc['evrMll'] as Map<String, dynamic>)
        : FTextTypeInput();
    revenueCatProductIdentifier = doc['revenueCatProdId'] != null
        ? FTextTypeInput.fromJson(
            doc['revenueCatProdId'] as Map<String, dynamic>,
          )
        : FTextTypeInput();
    revenueCatEntitlement = doc['revenueCatEntitle'] != null
        ? FTextTypeInput.fromJson(
            doc['revenueCatEntitle'] as Map<String, dynamic>,
          )
        : FTextTypeInput();
    qonversionProductIdentifier = doc['qonversionProdId'] != null
        ? FTextTypeInput.fromJson(
            doc['qonversionProdId'] as Map<String, dynamic>,
          )
        : FTextTypeInput();
    customHttpRequestURL = FTextTypeInput.fromJson(
      doc['sCustomHttpRequestURL'] as Map<String, dynamic>?,
    );
    customHttpRequestExpectedStatusCode = FTextTypeInput.fromJson(
      doc['sCustomHttpRequestExpectedStatusCode'] as Map<String, dynamic>?,
    );

    customHttpRequestHeader =
        (doc['sCustomHttpRequestHeader'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
    customHttpRequestList =
        (doc['sCustomHttpRequestList'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
    customHttpRequestBody =
        (doc['sCustomHttpRequestBody'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
    apiCallsRequestName = doc['aCRN'] as String?;
    apiCallsSelectedRequest = doc['aCSR'] as Map<String, dynamic>?;
    apiCallsResponseName = FTextTypeInput.fromJson(
      doc['aCResN'] as Map<String, dynamic>?,
    );
    apiCallsRequestName = doc['aCRN'] as String?;
    apiCallsSelectedRequest = doc['aCSR'] as Map<String, dynamic>?;
    apiCallsResponseName = FTextTypeInput.fromJson(
      doc['aCResN'] as Map<String, dynamic>?,
    );
    apiCallsDynamicValue =
        (doc['sApiCallsDynamicValue'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();

    //Firebase Analytics
    firebaseAnalyticsLoginMethod = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsLoginMethod'] as Map<String, dynamic>?,
    );
    firebaseAnalyticsParameters =
        (doc['sFirebaseAnalyticsParameters'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
    firebaseAnalyticsName = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsName'] as Map<String, dynamic>?,
    );

    firebaseAnalyticsGroupId = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsGroupId'] as Map<String, dynamic>?,
    );
    firebaseAnalyticsScreenName = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsScreenName'] as Map<String, dynamic>?,
    );

    firebaseAnalyticsContentType = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsContentType'] as Map<String, dynamic>?,
    );
    firebaseAnalyticsItemId = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsItemId'] as Map<String, dynamic>?,
    );
    firebaseAnalyticsMethod = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsMethod'] as Map<String, dynamic>?,
    );
    firebaseAnalyticsUserId = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsUserId'] as Map<String, dynamic>?,
    );
    firebaseAnalyticsValue = FTextTypeInput.fromJson(
      doc['sFirebaseAnalyticsValue'] as Map<String, dynamic>?,
    );
    firebaseMessagesTopic = FTextTypeInput.fromJson(
      doc['sFirebaseMessagesTopic'] as Map<String, dynamic>?,
    );
  }

  String? id;
  ActionType? actionType;
  ActionGesture? actionGesture;
  ActionNavigation? actionNavigation;
  ActionState? actionState;
  ActionRevenueCat? actionRevenueCat;
  ActionFirebaseAnalytics? actionFirebaseAnalytics;
  ActionFirebaseMessages? actionFirebaseMessages;
  ActionQonversion? actionQonversion;
  ActionMixpanel? actionMixpanel;
  ActionBraintree? actionBraintree;
  ActionTranslator? actionTranslator;
  ActionTheme? actionTheme;
  ActionStripe? actionStripe;
  ActionGoogleMaps? actionGoogleMaps;
  int? customFunctionId;
  ActionSupabaseAuth? actionSupabaseAuth;
  ActionSupabaseDB? actionSupabaseDB;
  ActionSupabaseFunctions? actionSupabaseFunctions;
  ActionSupabaseStorage? actionSupabaseStorage;
  ActionAirtableDB? actionAirtableDB;
  ActionCamera? actionCamera;
  ActionWebView? actionWebView;
  ActionAudioPlayerActions? actionAudioPlayer;
  ActionTetaCmsDB? actionTetaDB;
  ActionTetaCmsAuth? actionTetaAuth;
  ActionCustomHttpRequest? actionCustomHttpRequest;
  ActionApiCalls? actionApiCalls;
  FTextTypeInput? delay;
  FTextTypeInput? audioPlayerUrl = FTextTypeInput(value: 'url');
  bool? withCondition;
  FTextTypeInput? condition;
  FTextTypeInput? valueOfCondition;
  bool? withLoop;
  FTextTypeInput? everyMilliseconds;
  FTextTypeInput? revenueCatProductIdentifier;
  FTextTypeInput? revenueCatEntitlement;
  FTextTypeInput? qonversionProductIdentifier;

  String? prodId;
  String? stateName;
  String? stateName2;
  String? stateName3;
  String? stateName4;
  String? nameOfPage;
  String? nameOfDataset;
  Map<String, dynamic>? paramsToSend;
  String? value;
  FTextTypeInput? valueTextTypeInput;

  //email, phone, city, state, line1, postalCode, country
  FTextTypeInput? stripeBillingInfoEmail;
  FTextTypeInput? stripeBillingInfoPhone;
  FTextTypeInput? stripeBillingInfoCity;
  FTextTypeInput? stripeBillingInfoState;
  FTextTypeInput? stripeBillingInfoLine;
  FTextTypeInput? stripeBillingInfoPostalCode;
  FTextTypeInput? stripeBillingInfoCountry;
  FTextTypeInput? stripeShippingId;

  FTextTypeInput? stripePaymentIntentId;

  //lat, lng, zoom
  FTextTypeInput? googleMapsLat;
  FTextTypeInput? googleMapsLng;
  FTextTypeInput? googleMapsZoom;

  /// Supabase from
  FTextTypeInput? dbFrom;
  String? cmsCollectionId;

  /// External Api - Custom Http Request
  FTextTypeInput? customHttpRequestURL;
  FTextTypeInput? customHttpRequestExpectedStatusCode;
  List<MapElement>? customHttpRequestHeader;
  List<MapElement>? customHttpRequestList;
  List<MapElement>? customHttpRequestBody;

  /// Supabase data for insert / update map
  List<MapElement>? dbData;

  /// Supabase name of column for condition
  MapElement? dbEq;

  /// Airtable
  FTextTypeInput? airtableRecordName;

  /// Api Calls
  String? apiCallsRequestName;
  Map<String, dynamic>? apiCallsSelectedRequest;
  FTextTypeInput? apiCallsResponseName;
  List<MapElement>? apiCallsDynamicValue;

  //Firebase Analytics
  FTextTypeInput? firebaseAnalyticsLoginMethod;
  List<MapElement>? firebaseAnalyticsParameters;
  FTextTypeInput? firebaseAnalyticsName;

  FTextTypeInput? firebaseAnalyticsGroupId;
  FTextTypeInput? firebaseAnalyticsScreenName;
  FTextTypeInput? firebaseAnalyticsContentType;
  FTextTypeInput? firebaseAnalyticsItemId;
  FTextTypeInput? firebaseAnalyticsMethod;
  FTextTypeInput? firebaseAnalyticsUserId;
  FTextTypeInput? firebaseAnalyticsValue;
  //Firebase Messages
  FTextTypeInput? firebaseMessagesTopic;

  @override
  List<Object?> get props => [
        id,
        actionType,
        actionGesture,
        actionNavigation,
        actionState,
        actionWebView,
        actionAirtableDB,
        stateName,
        actionBraintree,
        actionTranslator,
        actionFirebaseAnalytics,
        actionFirebaseMessages,
        nameOfPage,
        paramsToSend,
        value,
        delay,
        withCondition,
        condition,
        valueOfCondition,
        withLoop,
        everyMilliseconds,
        dbFrom,
        cmsCollectionId,
        dbData,
        customHttpRequestURL,
        customHttpRequestExpectedStatusCode,
        customHttpRequestHeader,
        customHttpRequestList,
        customHttpRequestBody,
        apiCallsRequestName,
        apiCallsSelectedRequest,
        apiCallsResponseName,
        apiCallsDynamicValue,
        firebaseAnalyticsParameters,
      ];

  /// Get avaiable action types for drop down list
  List<String> getTypes(final ProjectConfig? config, final PageObject page) {
    if (config != null) {
      try {
        return [
          'State',
          'Navigation',
          'Teta database',
          'Teta auth',
          'Custom Http Request',
          'Api Calls',
          'Theme',
          'Languages',
          'Google Maps',
          if (kDebugMode) 'Custom Functions',
          if (config.isSupabaseReady) 'Supabase auth',
          if (config.isSupabaseReady) 'Supabase database',
          if (config.isSupabaseReady) 'Supabase functions',
          if (config.isSupabaseReady) 'Supabase storage',
          if (config.isBraintreeReady) 'Braintree',
          if (config.isFirebaseReady) 'Firebase Analytics',
          if (config.isFirebaseReady && config.isFirebasePushNotificationReady)
            'Firebase Messages',
          if (config.isRevenueCatEnabled) 'RevenueCat',
          if (config.isQonversionReady) 'Qonversion',
          if (config.isMixpanelReady) 'Mixpanel',
          if (config.isStripeEnabled) 'Stripe',
          if (config.isAirtableReady) 'Airtable Database',
          if ((page.flatList ?? <CNode>[]).indexWhere(
                (final element) => element.intrinsicState.type == NType.camera,
              ) !=
              -1)
            'Camera',
          if ((page.flatList ?? <CNode>[]).indexWhere(
                (final element) =>
                    element.intrinsicState.type == NType.audioPlayer,
              ) !=
              -1)
            'Audio player',
          if ((page.flatList ?? <CNode>[]).indexWhere(
                (final element) => element.intrinsicState.type == NType.webview,
              ) !=
              -1)
            'Webview',
          if ((page.flatList ?? <CNode>[]).indexWhere(
                (final element) =>
                    element.intrinsicState.type == NType.map ||
                    element.intrinsicState.type == NType.mapBuilder,
              ) !=
              -1)
            'Map',
        ].toList();
      } catch (e) {
        if (kDebugMode) {
          // ignore: avoid_print
          print(e);
        }
      }
    }
    return [
      'State',
      'Navigation',
    ];
  }

  static List<String> enumsToListString(final List<dynamic> values) {
    return EnumToString.toList<dynamic>(values, camelCase: true);
  }

  /// Returns list of avaiable gestures for dropdown
  static List<String> getGestures(final NDynamic node) {
    return enumsToListString(node.intrinsicState.gestures);
  }

  static List<String> getNavigation() {
    return enumsToListString(ActionNavigation.values);
  }

  static List<String> getState() {
    return enumsToListString(ActionState.values);
  }

  static List<String> getRevenueCat(final ProjectConfig? config) {
    if (config != null) {
      if (config.isRevenueCatEnabled) {
        return enumsToListString(ActionRevenueCat.values);
      }
    }
    return [];
  }

  static List<String> getQonversion(final ProjectConfig? config) {
    if (config != null) {
      if (config.isQonversionReady) {
        return enumsToListString(ActionQonversion.values);
      }
    }
    return [];
  }

  static List<String> getMixpanel(final ProjectConfig? config) {
    if (config != null) {
      if (config.isMixpanelReady) {
        return enumsToListString(ActionMixpanel.values);
      }
    }
    return [];
  }

  static List<String> getBraintree(final ProjectConfig? config) {
    if (config != null) {
      if (config.isBraintreeReady) {
        return enumsToListString(ActionBraintree.values);
      }
    }
    return [];
  }

  static List<String> getFirebaseAnalytics(final ProjectConfig? config) {
    if (config != null) {
      if (config.isFirebaseReady) {
        return enumsToListString(ActionFirebaseAnalytics.values);
      }
    }
    return [];
  }

  static List<String> getFirebaseMessages(final ProjectConfig? config) {
    if (config != null) {
      if (config.isFirebaseReady && config.isFirebasePushNotificationReady) {
        return enumsToListString(ActionFirebaseMessages.values);
      }
    }
    return [];
  }

  static List<String> getTranslator() {
    return enumsToListString(ActionTranslator.values);
  }

  static List<String> getStripe(final ProjectConfig? config) {
    return enumsToListString(ActionStripe.values);
  }

  static List<String> getGoogleMaps(final ProjectConfig? config) {
    return enumsToListString(ActionGoogleMaps.values);
  }

  static List<String> getTheme() {
    return enumsToListString(ActionTheme.values);
  }

  static List<String> getSupabaseAuth(final ProjectConfig? config) {
    if (config != null) {
      if (config.isSupabaseReady) {
        return enumsToListString(ActionSupabaseAuth.values);
      }
    }
    return [];
  }

  static List<String> getSupabaseDB(final ProjectConfig? config) {
    if (config != null) {
      if (config.isSupabaseReady) {
        return enumsToListString(ActionSupabaseDB.values);
      }
    }
    return [];
  }

  static List<String> getAirtableDB(final ProjectConfig? config) {
    if (config != null) {
      if (config.isAirtableReady) {
        return enumsToListString(ActionAirtableDB.values);
      }
    }
    return [];
  }

  static List<String> getSupabaseStorage(final ProjectConfig? config) {
    if (config != null) {
      if (config.isSupabaseReady) {
        return enumsToListString(ActionSupabaseStorage.values);
      }
    }
    return [];
  }

  static List<String> getSupabaseFunctions(final ProjectConfig? config) {
    if (config != null) {
      if (config.isSupabaseReady) {
        return enumsToListString(ActionSupabaseFunctions.values);
      }
    }
    return [];
  }

  static List<String> getTetaDB() {
    return enumsToListString(ActionTetaCmsDB.values);
  }

  static List<String> getTetaAuth() {
    return enumsToListString(ActionTetaCmsAuth.values);
  }

  static List<String> getCustomHttpRequest() {
    return enumsToListString(ActionCustomHttpRequest.values);
  }

  static List<String> getApiCalls() {
    return enumsToListString(ActionApiCalls.values);
  }

  static List<String> getCamera() {
    return enumsToListString(ActionCamera.values);
  }

  static List<String> getWebView() {
    return enumsToListString(ActionWebView.values);
  }

  static List<String> getAudioPlayer() {
    return enumsToListString(ActionAudioPlayerActions.values);
  }

  static String? convertValueToDropdown(final dynamic type) {
    if (type == ActionType.revenueCat) {
      return 'RevenueCat';
    }
    if (type == ActionType.qonversion) {
      return 'Qonversion';
    }
    if (type == ActionType.mixpanel) {
      return 'Mixpanel';
    }
    if (type == ActionType.stripe) {
      return 'Stripe';
    }
    if (type == ActionType.customFunctions) {
      return 'Custom Functions';
    }
    if (type == ActionType.theme) {
      return 'Theme';
    }

    if (type == ActionType.googleMaps) {
      return 'Google Maps';
    }

    if (type == ActionType.translator) {
      return 'Languages';
    }
    if (type == ActionType.customHttpRequest) {
      return 'Custom Http Request';
    }
    if (type == ActionType.apiCalls) {
      return 'Api Calls';
    }
    if (type == ActionType.airtable) return 'Airtable Database';
    if (type == ActionType.firebaseAnalytics) return 'Firebase Analytics';
    if (type == ActionType.firebaseMessages) return 'Firebase Messages';

    if (type != null) {
      return EnumToString.convertToString(type, camelCase: true);
    }
    return null;
  }

  static dynamic convertDropdownToValue(
    final List<dynamic> list,
    final String? value,
  ) {
    if (value == 'RevenueCat') {
      return ActionType.revenueCat;
    }
    if (value == 'Qonversion') {
      return ActionType.qonversion;
    }
    if (value == 'Mixpanel') {
      return ActionType.mixpanel;
    }
    if (value == 'Stripe') {
      return ActionType.stripe;
    }

    if (value == 'Google Maps') {
      return ActionType.googleMaps;
    }

    if (value == 'Custom Functions') {
      return ActionType.customFunctions;
    }
    if (value == 'Theme') {
      return ActionType.theme;
    }
    if (value == 'Languages') {
      return ActionType.translator;
    }
    if (value == 'Custom Http Request') {
      return ActionType.customHttpRequest;
    }
    if (value == 'Api Calls') {
      return ActionType.apiCalls;
    }
    if (value == 'Airtable Database') return ActionType.airtable;
    if (value == 'Firebase Analytics') return ActionType.firebaseAnalytics;
    if (value == 'Firebase Messages') return ActionType.firebaseMessages;
    if (value != null) {
      return EnumToString.fromString<dynamic>(list, value, camelCase: true);
    }
    return null;
  }

  @override
  String toString() => '''
    Action { 
      type: $actionType, 
      gesture: $actionGesture,  
    }
  ''';

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'aT': convertValueToDropdown(actionType),
        'cFid': customFunctionId,
        'aN': convertValueToDropdown(actionNavigation),
        'aTh': convertValueToDropdown(actionTheme),
        'aS': convertValueToDropdown(actionState),
        'g': convertValueToDropdown(actionGesture),
        'sA': convertValueToDropdown(actionSupabaseAuth),
        'sD': convertValueToDropdown(actionSupabaseDB),
        'aD': convertValueToDropdown(actionAirtableDB),
        'supaFuncs': convertValueToDropdown(actionSupabaseFunctions),
        'supaStor': convertValueToDropdown(actionSupabaseStorage),
        'aC': convertValueToDropdown(actionCamera),
        'aW': convertValueToDropdown(actionWebView),
        'aAP': convertValueToDropdown(actionAudioPlayer),
        'aRC': convertValueToDropdown(actionRevenueCat),
        'aQonversion': convertValueToDropdown(actionQonversion),
        'aMixpanel': convertValueToDropdown(actionMixpanel),
        'aBrain': convertValueToDropdown(actionBraintree),
        'aFirebaseAnalytics': convertValueToDropdown(actionFirebaseAnalytics),
        'aFirebaseMessages': convertValueToDropdown(actionFirebaseMessages),
        'aTrans': convertValueToDropdown(actionTranslator),
        'sPK': convertValueToDropdown(actionStripe),
        'actionGoogleMaps': convertValueToDropdown(actionGoogleMaps),
        'aTDb': convertValueToDropdown(actionTetaDB),
        'aTAu': convertValueToDropdown(actionTetaAuth),
        'aCHr': convertValueToDropdown(actionCustomHttpRequest),
        'aAC': convertValueToDropdown(actionApiCalls),
        'sN': stateName,
        'sN2': stateName2,
        'sN3': stateName3,
        'sN4': stateName4,
        'pTS': paramsToSend,
        'pN': nameOfPage,
        'v': value,
        'sFrom': dbFrom != null ? dbFrom!.toJson() : null,
        'cmsCId': cmsCollectionId,
        'sData': dbData != null
            ? dbData!.map((final e) => e.toJson()).toList()
            : null,
        'sEq': dbEq != null ? dbEq!.toJson() : null,
        'delay': delay != null ? delay!.toJson() : null,
        'audioPlayerUrl':
            audioPlayerUrl != null ? audioPlayerUrl!.toJson() : null,
        'wCond': withCondition,
        'cond': condition != null ? condition!.toJson() : null,
        'vCond': valueOfCondition != null ? valueOfCondition!.toJson() : null,
        'wLoop': withLoop,
        'evrMll':
            everyMilliseconds != null ? everyMilliseconds!.toJson() : null,
        'vTTI':
            valueTextTypeInput != null ? valueTextTypeInput!.toJson() : null,
        //email, phone, city, state, line1, postalCode, country
        'stripeBillingInfoEmail': stripeBillingInfoEmail != null
            ? stripeBillingInfoEmail!.toJson()
            : null,
        'stripePaymentIntentId': stripePaymentIntentId != null
            ? stripePaymentIntentId!.toJson()
            : null,
        'stripeBillingInfoPhone': stripeBillingInfoPhone != null
            ? stripeBillingInfoPhone!.toJson()
            : null,
        'stripeBillingInfoCity': stripeBillingInfoCity != null
            ? stripeBillingInfoCity!.toJson()
            : null,
        'stripeBillingInfoState': stripeBillingInfoState != null
            ? stripeBillingInfoState!.toJson()
            : null,
        'stripeBillingInfoLine': stripeBillingInfoLine != null
            ? stripeBillingInfoLine!.toJson()
            : null,
        'stripeBillingInfoPostalCode': stripeBillingInfoPostalCode != null
            ? stripeBillingInfoPostalCode!.toJson()
            : null,
        'stripeBillingInfoCountry': stripeBillingInfoCountry != null
            ? stripeBillingInfoCountry!.toJson()
            : null,
        'stripeShippingId':
            stripeShippingId != null ? stripeShippingId!.toJson() : null,
        //lat, lng, zoom
        'googleMapsLat': googleMapsLat != null ? googleMapsLat!.toJson() : null,
        'googleMapsLng': googleMapsLng != null ? googleMapsLng!.toJson() : null,
        'googleMapsZoom':
            googleMapsZoom != null ? googleMapsZoom!.toJson() : null,
        'revenueCatEntitle': revenueCatEntitlement != null
            ? revenueCatEntitlement!.toJson()
            : null,
        'revenueCatProdId': revenueCatProductIdentifier != null
            ? revenueCatProductIdentifier!.toJson()
            : null,
        'qonversionProdId': qonversionProductIdentifier != null
            ? qonversionProductIdentifier!.toJson()
            : null,
        'sCustomHttpRequestHeader': customHttpRequestHeader != null
            ? customHttpRequestHeader!.map((final e) => e.toJson()).toList()
            : null,
        'sCustomHttpRequestList': customHttpRequestList != null
            ? customHttpRequestList!.map((final e) => e.toJson()).toList()
            : null,
        'sCustomHttpRequestBody': customHttpRequestBody != null
            ? customHttpRequestBody!.map((final e) => e.toJson()).toList()
            : null,
        'sCustomHttpRequestURL': customHttpRequestURL != null
            ? customHttpRequestURL!.toJson()
            : null,
        'sCustomHttpRequestExpectedStatusCode':
            customHttpRequestExpectedStatusCode != null
                ? customHttpRequestExpectedStatusCode!.toJson()
                : null,
        'aCRN': apiCallsRequestName,
        'aCSR': apiCallsSelectedRequest,
        'aCResN': apiCallsResponseName,

        'sApiCallsDynamicValue': apiCallsDynamicValue != null
            ? apiCallsDynamicValue!.map((final e) => e.toJson()).toList()
            : null,
        'sFirebaseAnalyticsLoginMethod': firebaseAnalyticsLoginMethod != null
            ? firebaseAnalyticsLoginMethod!.toJson()
            : null,
        'sFirebaseAnalyticsParameters': firebaseAnalyticsParameters != null
            ? firebaseAnalyticsParameters!.map((final e) => e.toJson()).toList()
            : null,
        'sFirebaseAnalyticsName': firebaseAnalyticsName != null
            ? firebaseAnalyticsName!.toJson()
            : null,

        'sFirebaseAnalyticsGroupId': firebaseAnalyticsGroupId != null
            ? firebaseAnalyticsGroupId!.toJson()
            : null,
        'sFirebaseAnalyticsScreenName': firebaseAnalyticsScreenName != null
            ? firebaseAnalyticsScreenName!.toJson()
            : null,

        'sFirebaseAnalyticsContentType': firebaseAnalyticsContentType != null
            ? firebaseAnalyticsContentType!.toJson()
            : null,
        'sFirebaseAnalyticsItemId': firebaseAnalyticsItemId != null
            ? firebaseAnalyticsItemId!.toJson()
            : null,
        'sFirebaseAnalyticsMethod': firebaseAnalyticsMethod != null
            ? firebaseAnalyticsMethod!.toJson()
            : null,
        'sFirebaseAnalyticsUserId': firebaseAnalyticsUserId != null
            ? firebaseAnalyticsUserId!.toJson()
            : null,
        'sFirebaseAnalyticsValue': firebaseAnalyticsValue != null
            ? firebaseAnalyticsValue!.toJson()
            : null,
        'sFirebaseMessagesTopic': firebaseMessagesTopic != null
            ? firebaseMessagesTopic!.toJson()
            : null,
      }..removeWhere((final String key, final dynamic value) => value == null);

  Future getAction(
    final BuildContext context,
    final TetaWidgetState state,
    final String? value,
    final CNode scaffold,
  ) async {
    Logger.printSuccess(actionType.toString());
    switch (actionType) {
      case ActionType.theme:
        switch (actionTheme) {
          case ActionTheme.changeTheme:
            await actionS(
              () => FActionChangeTheme.action(context),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.customFunctions:
        if (withCondition == true) {
          if (condition?.get(
                state.params,
                state.states,
                state.dataset,
                true,
                state.loop,
                context,
              ) !=
              valueOfCondition?.get(
                state.params,
                state.states,
                state.dataset,
                true,
                state.loop,
                context,
              )) {
            break;
          }
        }
        await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
        FLoop.action(
          () => FActionCustomFunction.action(
            context,
            customFunctionId,
          ),
          everyMilliseconds,
          context,
          withLoop: withLoop ?? false,
        );
        break;
      case ActionType.tetaDatabase:
        switch (actionTetaDB) {
          case ActionTetaCmsDB.insert:
            await actionS(
              () => FATetaCMSInsert.action(
                context,
                cmsCollectionId,
                dbData,
                state,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionTetaCmsDB.update:
            await actionS(
              () => FATetaCMSUpdate.action(
                context,
                cmsCollectionId,
                dbData,
                dbFrom,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionTetaCmsDB.delete:
            await actionS(
              () => FATetaCMSDelete.action(
                context,
                cmsCollectionId,
                dbFrom,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
        }
        break;
      case ActionType.tetaAuth:
        switch (actionTetaAuth) {
          case ActionTetaCmsAuth.signInWithGoogle:
            await actionS(
              () => FATetaCMSLogin.action(
                context,
                state,
                nameOfPage,
                paramsToSend,
                TetaProvider.google,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionTetaCmsAuth.signInWithGitHub:
            await actionS(
              () => FATetaCMSLogin.action(
                context,
                state,
                nameOfPage,
                paramsToSend,
                TetaProvider.github,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionTetaCmsAuth.signInWithTwitter:
            await actionS(
              () => FATetaCMSLogin.action(
                context,
                state,
                nameOfPage,
                paramsToSend,
                TetaProvider.twitter,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionTetaCmsAuth.signInWithApple:
            await actionS(
              () => FATetaCMSLogin.action(
                context,
                state,
                nameOfPage,
                paramsToSend,
                TetaProvider.apple,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionTetaCmsAuth.logout:
            await actionS(
              () => FATetaCMSLogout.action(
                context,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.customHttpRequest:
        switch (actionCustomHttpRequest) {
          case ActionCustomHttpRequest.delete:
            await actionS(
              () => FACustomHttpRequestDelete.action(
                context,
                state,
                customHttpRequestURL,
                customHttpRequestExpectedStatusCode,
                customHttpRequestList,
                customHttpRequestHeader,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionCustomHttpRequest.post:
            await actionS(
              () => FACustomHttpRequestPost.action(
                context,
                state,
                customHttpRequestURL,
                customHttpRequestExpectedStatusCode,
                customHttpRequestList,
                customHttpRequestBody,
                customHttpRequestHeader,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionCustomHttpRequest.update:
            await actionS(
              () => FACustomHttpRequestUpdate.action(
                context,
                state,
                customHttpRequestURL,
                customHttpRequestExpectedStatusCode,
                customHttpRequestList,
                customHttpRequestBody,
                customHttpRequestHeader,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.apiCalls:
        switch (actionApiCalls) {
          case ActionApiCalls.apiCalls:
            await actionS(
              () => FAApiCalls.action(
                context,
                apiCallsRequestName,
                apiCallsSelectedRequest,
                customHttpRequestExpectedStatusCode,
                apiCallsResponseName,
                apiCallsDynamicValue,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.revenueCat:
        switch (actionRevenueCat) {
          case ActionRevenueCat.buy:
            await actionS(
              () => FActionRevenueCatBuy.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                revenueCatProductIdentifier,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionRevenueCat.restorePurchases:
            await actionS(
              () => FActionRevenueCatRestorePurchases.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.firebaseMessages:
        switch (actionFirebaseMessages) {
          case ActionFirebaseMessages.subscribeToTopic:
            await actionS(
              () => FActionFirebaseMessagesSubscribeTopic.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseMessagesTopic,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseMessages.unsubscribeToTopic:
            await actionS(
              () => FActionFirebaseMessagesUnsubscribeTopic.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseMessagesTopic,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.firebaseAnalytics:
        switch (actionFirebaseAnalytics) {
          case ActionFirebaseAnalytics.logEvent:
            await actionS(
              () => FActionFirebaseAnalyticsLogEvent.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsParameters,
                firebaseAnalyticsName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.logLogin:
            await actionS(
              () => FActionFirebaseAnalyticsLogLogin.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsLoginMethod,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.logScreenView:
            await actionS(
              () => FActionFirebaseAnalyticsLogScreenView.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsScreenName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.logShare:
            await actionS(
              () => FActionFirebaseAnalyticsLogShare.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsContentType,
                firebaseAnalyticsItemId,
                firebaseAnalyticsMethod,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.logJoinGroup:
            await actionS(
              () => FActionFirebaseAnalyticsLogJoinGroup.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsGroupId,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.logAppOpen:
            await actionS(
              () => FActionFirebaseAnalyticsLogAppOpen.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.resetAnalyticsData:
            await actionS(
              () => FActionFirebaseAnalyticsResetAnalyticsData.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.setUserProperty:
            await actionS(
              () => FActionFirebaseAnalyticsSetUserProperty.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsName,
                firebaseAnalyticsValue,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.setCurrentScreen:
            await actionS(
              () => FActionFirebaseAnalyticsSetCurrentScreen.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsScreenName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionFirebaseAnalytics.setUserId:
            await actionS(
              () => FActionFirebaseAnalyticsSetUserId.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                stateName,
                firebaseAnalyticsUserId,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.mixpanel:
        switch (actionMixpanel) {
          case ActionMixpanel.setUserId:
            await actionS(
              () => FAMixpanelSetUserId.action(
                context,
                valueTextTypeInput,
                state.params,
                state.states,
                state.dataset,
                state.loop ?? 0,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionMixpanel.track:
            await actionS(
              () => FAMixpanelTrack.action(
                context,
                valueTextTypeInput,
                customHttpRequestBody,
                state.params,
                state.states,
                state.dataset,
                state.loop ?? 0,
              ),
              context: context,
              state: state,
            );
            break;
        }
        break;
      case ActionType.qonversion:
        switch (actionQonversion) {
          case ActionQonversion.buy:
            await actionS(
              () => FActionQonversionBuy.action(
                context,
                state.copyWith(loop: state.loop ?? 0),
                qonversionProductIdentifier,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionQonversion.restorePurchases:
            await actionS(
              () => FActionQonversionRestorePurchases.action(
                context,
                state.states,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.braintree:
        switch (actionBraintree) {
          case ActionBraintree.pay:
            await actionS(
              () => FActionBraintreeBuy.action(context, state, stateName),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.translator:
        switch (actionTranslator) {
          case ActionTranslator.translate:
            await actionS(
              () => FActionTranslatorTranslate.action(
                context,
                state.states,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.googleMaps:
        switch (actionGoogleMaps) {
          case ActionGoogleMaps.reloadData:
            await actionS(
              () => FActionGoogleMapsReloadData.action(
                context,
                state.states,
                stateName,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionGoogleMaps.setCameraPosition:
            await actionS(
              () => FActionGoogleMapsSetCameraPosition.action(
                context,
                state.states,
                stateName,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionGoogleMaps.updateLiveLocation:
            await actionS(
              () => FActionGoogleMapsUpdateDeviceLiveLocation.action(
                context,
                state,
                stateName,
                stateName2,
              ),
              context: context,
              state: state,
            );
        }
        break;
      case ActionType.stripe:
        switch (actionStripe) {
          case ActionStripe.showReceipt:
            await actionS(
              () => FActionStripeShowReceipt.action(
                context,
                state.states,
                stateName,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionStripe.buyCartItems:
            await actionS(
              () => FActionStripeCartBuyAll.action(
                context,
                state.states,
                stateName,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionStripe.addProductsListItemToCart:
            await actionS(
              () => FActionStripeAddProductsListItemToCart.action(
                context,
                state.states,
                stateName,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionStripe.removeCartListItemFromCart:
            await actionS(
              () => FActionStripeCartRemoveProductsListItemFromCart.action(
                context,
                state.states,
                stateName,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.state:
        switch (actionState) {
          case ActionState.increment:
            await actionS(
              () => FActionStateIncrement.action(
                context,
                state.states,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.decrement:
            await actionS(
              () => FActionStateDecrement.action(
                context,
                state.states,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.changeWith:
            await actionS(
              () => FActionStateChangeWith.action(
                context: context,
                states: state.states,
                params: state.params,
                datasets: state.dataset,
                stateName: stateName,
                valueToChangeWith: valueTextTypeInput ?? FTextTypeInput(),
                value: value,
                loop: state.loop ?? 0,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.pickFile:
            await actionS(
              () => FActionStateFilePicker.action(
                context: context,
                states: state.states,
                params: state.params,
                datasets: state.dataset,
                stateName: stateName,
                loop: state.loop ?? 0,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.changeWithParams:
            await actionS(
              () => FActionStateChangeWithParam.action(
                context,
                state,
                stateName,
                this.value,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.emailValidator:
            await actionS(
              () => FActionEmailValidator.action(
                context: context,
                states: state.states,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.passwordValidator:
            await actionS(
              () => FActionPasswordValidator.action(
                context: context,
                states: state.states,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.websiteValidator:
            await actionS(
              () => FActionWebsiteValidator.action(
                context: context,
                states: state.states,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionState.phoneValidator:
            await actionS(
              () => FActionPhoneValidator.action(
                context: context,
                states: state.states,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context: context,
              state: state,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.navigation:
        switch (actionNavigation) {
          case ActionNavigation.goBack:
            await actionS(
              () => FActionNavigationGoBack.action(context),
              context: context,
              state: state,
            );
            break;
          case ActionNavigation.openDrawer:
            await actionS(
              () => FActionNavigationOpenDrawer.action(context),
              context: context,
              state: state,
            );
            break;
          case ActionNavigation.openPage:
            await actionS(
              () => FActionNavigationOpenPage.action(
                context,
                state,
                nameOfPage,
                paramsToSend,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionNavigation.launchURL:
            PackagesService.instance
                .insertPackages(FActionNavigationLaunchURL.packages);
            await actionS(
              () => FActionNavigationLaunchURL.action(
                context: context,
                state: state.copyWith(
                  loop: state.loop ?? 0,
                ),
                value: valueTextTypeInput ?? FTextTypeInput(),
              ),
              context: context,
              state: state,
            );
            break;
          case ActionNavigation.share:
            await actionS(
              () => FActionNavigationShare.action(
                context: context,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionNavigation.openBottomSheet:
            await actionS(
              () => FActionNavigationOpenBottomSheet.action(
                context,
                state,
                nameOfPage,
                paramsToSend,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionNavigation.openSnackBar:
            await actionS(
              () => FActionNavigationOpenSnackBar.action(
                context,
                state,
                nameOfPage,
                paramsToSend,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionNavigation.openDatePicker:
            await actionS(
              () => FActionNavigationOpenDatePicker.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionNavigation.inAppReview:
            await actionS(
              () => FActionNavigationInAppReview.action(
                context,
              ),
              context: context,
              state: state,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.airtable:
        switch (actionAirtableDB) {
          case null:
            break;
          case ActionAirtableDB.insert:
            await actionS(
              () => FAAirtableInsert.action(
                context,
                airtableRecordName,
                dbData ?? [],
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionAirtableDB.delete:
            await actionS(
              () => FAAirtableDelete.action(
                context,
                airtableRecordName,
                dbData ?? [],
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionAirtableDB.update:
            await actionS(
              () => FAAirtableUpdate.action(
                context,
                airtableRecordName,
                dbData ?? [],
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
        }
        break;
      case ActionType.supabaseAuth:
        switch (actionSupabaseAuth) {
          case ActionSupabaseAuth.signUp:
            await actionS(
              () => FASupabaseSignUp.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionSupabaseAuth.signInWithCredential:
            await actionS(
              () => FASupabaseSignInWithCredentials.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithGoogle:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.google,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithApple:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.apple,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithFacebook:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.facebook,
              ),
              context: context,
              state: state,
            );

            break;

          case ActionSupabaseAuth.signInWithAzure:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.azure,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithBitbucket:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.bitbucket,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithDiscord:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.discord,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithGitLab:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.gitlab,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithSlack:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.slack,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithSpotify:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.spotify,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithTwitch:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.twitch,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionSupabaseAuth.signInWithTwitter:
            await actionS(
              () => FASupabaseSignInWithProvider.action(
                context,
                state,
                value ?? this.value ?? '',
                scaffold,
                nameOfPage,
                paramsToSend,
                Provider.twitter,
              ),
              context: context,
              state: state,
            );

            break;
          case null:
            break;
        }
        break;
      case ActionType.supabaseStorage:
        switch (actionSupabaseStorage) {
          case ActionSupabaseStorage.upload:
            await actionS(
              () => FASupabaseStorageUpload.action(
                context,
                dbFrom,
                valueTextTypeInput,
                stateName,
                stateName2,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionSupabaseStorage.remove:
            await actionS(
              () => FASupabaseStorageRemove.action(
                context,
                dbFrom,
                valueTextTypeInput,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.supabaseFunctions:
        switch (actionSupabaseFunctions) {
          case ActionSupabaseFunctions.invoke:
            await actionS(
              () => FASupabaseFunctionsInvoke.action(
                context,
                dbFrom,
                customHttpRequestBody,
                customHttpRequestHeader,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.camera:
        switch (actionCamera) {
          case ActionCamera.takePhoto:
            await actionS(
              () => FACameraTakePhoto.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionCamera.switchCamera:
            await actionS(
              () => FACameraSwitch.action(
                context,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionCamera.offFlash:
            await actionS(
              () => FACameraOffFlash.action(context),
              context: context,
              state: state,
            );
            break;
          case ActionCamera.alwaysFlash:
            await actionS(
              () => FACameraAlwaysFlash.action(context),
              context: context,
              state: state,
            );
            break;
          case ActionCamera.autoFlash:
            await actionS(
              () => FACameraAutoFlash.action(context, state),
              context: context,
              state: state,
            );
            break;
          case ActionCamera.torchFlash:
            await actionS(
              () => FACameraTorchFlash.action(context, stateName),
              context: context,
              state: state,
            );
            break;
          case ActionCamera.toggleRecording:
            await actionS(
              () => FACameraStopRecording.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;

          case null:
            break;
        }
        break;
      case ActionType.webview:
        switch (actionWebView) {
          case ActionWebView.navigateTo:
            await actionS(
              () => FActionWebViewNavigateTo.action(
                context: context,
                params: state.params,
                states: state.states,
                datasets: state.dataset,
                stateName: stateName,
                valueToChangeWith: valueTextTypeInput ?? FTextTypeInput(),
                loop: state.loop ?? 0,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionWebView.goBack:
            await actionS(
              () => FActionWebViewBack.action(
                context,
                state.states,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionWebView.reload:
            await actionS(
              () => FActionWebViewReload.action(
                context,
                state.states,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionWebView.goForward:
            await actionS(
              () => FActionWebViewForward.action(
                context,
                state.states,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.audioPlayer:
        switch (actionAudioPlayer) {
          case ActionAudioPlayerActions.play:
            await actionS(
              () => FAudioPlayerPlay.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionAudioPlayerActions.playNextTrack:
            await actionS(
              () => FAudioPlayerPlayNextTrack.action(
                context,
                state,
                stateName,
                audioPlayerUrl!.get(
                  state.params,
                  state.states,
                  state.dataset,
                  true,
                  state.loop,
                  context,
                ),
              ),
              context: context,
              state: state,
            );
            break;
          case ActionAudioPlayerActions.playPreviousTrack:
            await actionS(
              () => FAudioPlayerPlayPreviousTrack.action(
                context,
                state,
                stateName,
                audioPlayerUrl!.get(
                  state.params,
                  state.states,
                  state.dataset,
                  true,
                  state.loop,
                  context,
                ),
              ),
              context: context,
              state: state,
            );
            break;
          case ActionAudioPlayerActions.pause:
            await actionS(
              () => FAudioPlayerPause.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionAudioPlayerActions.reload:
            await actionS(
              () => FAudioPlayerReload.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionAudioPlayerActions.loopOff:
            await actionS(
              () => FAudioPlayerLoopOff.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionAudioPlayerActions.loopOne:
            await actionS(
              () => FAudioPlayerLoopOne.action(
                context,
                state,
                stateName,
              ),
              context: context,
              state: state,
            );

            break;
          case ActionAudioPlayerActions.loopAll:
            await actionS(
              () => FAudioPlayerLoopAll.action(state, stateName),
              context: context,
              state: state,
            );

            break;
          case null:
            break;
        }
        break;
      case null:
        break;
      case ActionType.shopify:
        break;
      case ActionType.firebase:
        break;
      case ActionType.firebaseFirestore:
        break;
      case ActionType.firebaseStorage:
        break;
      case ActionType.supabaseDatabase:
        switch (actionSupabaseDB) {
          case ActionSupabaseDB.insert:
            Logger.printMessage('dbFrom: ${dbFrom!.value!}');
            await actionS(
              () => FASupabaseInsert.action(
                context,
                dbFrom,
                dbData,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionSupabaseDB.delete:
            Logger.printMessage('dbFrom: ${dbFrom!.value!}');
            await actionS(
              () => FASupabaseDelete.action(
                context,
                dbFrom,
                dbEq!,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case ActionSupabaseDB.update:
            Logger.printMessage('dbFrom: ${dbFrom!.value!}');
            await actionS(
              () => FASupabaseUpdate.action(
                context,
                dbFrom,
                dbData,
                dbEq!,
                state.params,
                state.states,
                state.dataset,
                state.loop,
              ),
              context: context,
              state: state,
            );
            break;
          case null:
            return '';
        }
    }
  }

  //TODO: add here on each case action the add package to package service
  String toCode({
    required final int pageId,
    required final BuildContext context,
    required final CNode body,
    final String? value,
    final bool withValue = false,
    final int loop = 0,
  }) {
    switch (actionType) {
      case ActionType.theme:
        switch (actionTheme) {
          case ActionTheme.changeTheme:
            return codeS(
              FActionChangeTheme.toCode(
                context,
              ),
              context,
            );
        }
        break;
      case ActionType.customFunctions:
        return codeS(
          FActionCustomFunction.toCode(
            context,
            customFunctionId,
          ),
          context,
        );
      case ActionType.tetaDatabase:
        switch (actionTetaDB) {
          case ActionTetaCmsDB.insert:
            return codeS(
              FATetaCMSInsert.toCode(
                cmsCollectionId,
                dbData,
              ),
              context,
            );
          case ActionTetaCmsDB.delete:
            return codeS(
              FATetaCMSDelete.toCode(
                cmsCollectionId,
                dbFrom,
                loop,
              ),
              context,
            );
          case ActionTetaCmsDB.update:
            return codeS(
              FATetaCMSUpdate.toCode(
                cmsCollectionId,
                dbData,
                dbFrom,
                loop,
              ),
              context,
            );
        }
        break;
      case ActionType.customHttpRequest:
        switch (actionCustomHttpRequest) {
          case ActionCustomHttpRequest.delete:
            return codeS(
              FACustomHttpRequestDelete.toCode(
                customHttpRequestURL,
                customHttpRequestExpectedStatusCode,
                customHttpRequestList,
                customHttpRequestHeader,
                loop,
              ),
              context,
            );
          case ActionCustomHttpRequest.update:
            return codeS(
              FACustomHttpRequestUpdate.toCode(
                customHttpRequestURL,
                customHttpRequestExpectedStatusCode,
                customHttpRequestList,
                customHttpRequestBody,
                customHttpRequestHeader,
                loop,
              ),
              context,
            );

          case ActionCustomHttpRequest.post:
            return codeS(
              FACustomHttpRequestPost.toCode(
                customHttpRequestURL,
                customHttpRequestExpectedStatusCode,
                customHttpRequestList,
                customHttpRequestBody,
                customHttpRequestHeader,
                loop,
              ),
              context,
            );
          default:
            break;
        }
        break;
      case ActionType.apiCalls:
        switch (actionApiCalls) {
          case ActionApiCalls.apiCalls:
            return codeS(
              FAApiCalls.toCode(
                apiCallsRequestName,
                apiCallsSelectedRequest,
                customHttpRequestExpectedStatusCode,
                apiCallsResponseName,
                apiCallsDynamicValue,
                loop,
              ),
              context,
            );
          default:
            break;
        }

        break;
      case ActionType.tetaAuth:
        switch (actionTetaAuth) {
          case ActionTetaCmsAuth.signInWithGoogle:
            return codeS(
              FATetaCMSLogin.toCode(
                context,
                TetaProvider.google,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );
          case ActionTetaCmsAuth.signInWithGitHub:
            return codeS(
              FATetaCMSLogin.toCode(
                context,
                TetaProvider.github,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );
          case ActionTetaCmsAuth.signInWithTwitter:
            return codeS(
              FATetaCMSLogin.toCode(
                context,
                TetaProvider.twitter,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );
          case ActionTetaCmsAuth.signInWithApple:
            return codeS(
              FATetaCMSLogin.toCode(
                context,
                TetaProvider.apple,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );
          case ActionTetaCmsAuth.logout:
            return codeS(FATetaCMSLogout.toCode(), context);
          default:
            break;
        }
        break;
      case ActionType.revenueCat:
        switch (actionRevenueCat) {
          case ActionRevenueCat.buy:
            return codeS(
              FActionRevenueCatBuy.toCode(
                context,
                revenueCatProductIdentifier,
                stateName,
                pageId,
                -loop,
              ),
              context,
            );
          case ActionRevenueCat.restorePurchases:
            return codeS(
              FActionRevenueCatRestorePurchases.toCode(
                context,
                stateName,
                pageId,
              ),
              context,
            );
          default:
            break;
        }
        break;
      case ActionType.firebaseMessages:
        switch (actionFirebaseMessages) {
          case ActionFirebaseMessages.subscribeToTopic:
            return codeS(
              FActionFirebaseMessagesSubscribeTopic.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseMessagesTopic,
              ),
              context,
            );
          case ActionFirebaseMessages.unsubscribeToTopic:
            return codeS(
              FActionFirebaseMessagesUnsubscribeTopic.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseMessagesTopic,
              ),
              context,
            );

          default:
            break;
        }
        break;
      case ActionType.firebaseAnalytics:
        switch (actionFirebaseAnalytics) {
          case ActionFirebaseAnalytics.logLogin:
            return codeS(
              FActionFirebaseAnalyticsLogLogin.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsLoginMethod,
              ),
              context,
            );
          case ActionFirebaseAnalytics.logEvent:
            return codeS(
              FActionFirebaseAnalyticsLogEvent.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsParameters,
                firebaseAnalyticsName,
              ),
              context,
            );
          case ActionFirebaseAnalytics.logScreenView:
            return codeS(
              FActionFirebaseAnalyticsLogScreenView.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsScreenName,
              ),
              context,
            );
          case ActionFirebaseAnalytics.logShare:
            return codeS(
              FActionFirebaseAnalyticsLogShare.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsContentType,
                firebaseAnalyticsItemId,
                firebaseAnalyticsMethod,
              ),
              context,
            );
          case ActionFirebaseAnalytics.logJoinGroup:
            return codeS(
              FActionFirebaseAnalyticsLogJoinGroup.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsGroupId,
              ),
              context,
            );
          case ActionFirebaseAnalytics.logAppOpen:
            return codeS(
              FActionFirebaseAnalyticsLogAppOpen.toCode(
                context,
                stateName,
                pageId,
                loop,
              ),
              context,
            );
          case ActionFirebaseAnalytics.resetAnalyticsData:
            return codeS(
              FActionFirebaseAnalyticsResetAnalyticsData.toCode(
                context,
                stateName,
                pageId,
                loop,
              ),
              context,
            );
          case ActionFirebaseAnalytics.setUserProperty:
            return codeS(
              FActionFirebaseAnalyticsSetUserProperty.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsName,
                firebaseAnalyticsValue,
              ),
              context,
            );
          case ActionFirebaseAnalytics.setCurrentScreen:
            return codeS(
              FActionFirebaseAnalyticsSetCurrentScreen.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsScreenName,
              ),
              context,
            );
          case ActionFirebaseAnalytics.setUserId:
            return codeS(
              FActionFirebaseAnalyticsSetUserId.toCode(
                context,
                stateName,
                pageId,
                loop,
                firebaseAnalyticsUserId,
              ),
              context,
            );
          default:
            break;
        }
        break;
      case ActionType.qonversion:
        switch (actionQonversion) {
          case ActionQonversion.buy:
            return codeS(
              FActionQonversionBuy.toCode(
                context,
                revenueCatProductIdentifier,
                stateName,
                pageId,
                -loop,
              ),
              context,
            );
          case ActionQonversion.restorePurchases:
            return codeS(
              FActionQonversionRestorePurchases.toCode(
                context,
                stateName,
                pageId,
              ),
              context,
            );
          default:
            break;
        }
        break;
      case ActionType.mixpanel:
        switch (actionMixpanel) {
          case ActionMixpanel.setUserId:
            return codeS(
              FAMixpanelSetUserId.toCode(
                context,
                valueTextTypeInput,
              ),
              context,
            );
          case ActionMixpanel.track:
            return codeS(
              FAMixpanelTrack.toCode(
                context,
                valueTextTypeInput,
                customHttpRequestBody,
              ),
              context,
            );
        }
        break;
      case ActionType.braintree:
        switch (actionBraintree) {
          case ActionBraintree.pay:
            return codeS(
              FActionBraintreeBuy.toCode(
                context,
                pageId,
                valueTextTypeInput,
                stateName,
                loop: loop,
              ),
              context,
            );
          default:
            break;
        }
        break;
      case ActionType.translator:
        switch (actionTranslator) {
          case ActionTranslator.translate:
            return codeS(
              FActionTranslatorTranslate.toCode(context, pageId, stateName),
              context,
            );
          default:
            break;
        }
        break;
      case ActionType.googleMaps:
        switch (actionGoogleMaps) {
          case ActionGoogleMaps.reloadData:
            return codeS(
              FActionGoogleMapsReloadData.toCode(
                pageId,
                context,
                stateName,
                loop,
              ),
              context,
            );
          case ActionGoogleMaps.setCameraPosition:
            return codeS(
              FActionGoogleMapsSetCameraPosition.toCode(
                pageId,
                context,
                stateName,
                loop,
                googleMapsLat?.toCode(
                      null,
                      resultType: ResultTypeEnum.double,
                    ) ??
                    '',
                googleMapsLng?.toCode(
                      null,
                      resultType: ResultTypeEnum.double,
                    ) ??
                    '',
                googleMapsZoom?.toCode(
                      null,
                      resultType: ResultTypeEnum.double,
                    ) ??
                    '',
              ),
              context,
            );
          case ActionGoogleMaps.updateLiveLocation:
            return codeS(
              FActionGoogleMapsUpdateDeviceLiveLocation.toCode(
                context,
                pageId,
                stateName3,
                stateName4,
              ),
              context,
            );
          case null:
            return '';
        }
        break;
      case ActionType.stripe:
        switch (actionStripe) {
          case ActionStripe.showReceipt:
            return codeS(
              FActionStripeShowReceipt.toCode(
                context,
                stateName,
                body,
                paymentIntentId: stripePaymentIntentId?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
              ),
              context,
            );
          case ActionStripe.buyCartItems:
            return codeS(
              FActionStripeCartBuyAll.toCode(
                context,
                stateName,
                body,
                email: stripeBillingInfoEmail?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
                phone: stripeBillingInfoPhone?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
                city: stripeBillingInfoCity?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
                state: stripeBillingInfoState?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
                line: stripeBillingInfoLine?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
                postalCode: stripeBillingInfoPostalCode?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
                country: stripeBillingInfoCountry?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
                shippingId: stripeShippingId?.toCode(
                      null,
                      resultType: ResultTypeEnum.string,
                    ) ??
                    '',
              ),
              context,
            );
          case ActionStripe.addProductsListItemToCart:
            return codeS(
              FActionStripeAddProductsListItemToCart.toCode(
                context,
                stateName,
                body,
              ),
              context,
            );
          case ActionStripe.removeCartListItemFromCart:
            return codeS(
              FActionStripeCartRemoveProductsListItemFromCart.toCode(
                context,
                stateName,
                body,
              ),
              context,
            );
            break;
        }
        break;
      case ActionType.state:
        switch (actionState) {
          case ActionState.increment:
            return codeS(
              FActionStateIncrement.toCode(pageId, context, stateName),
              context,
            );
          case ActionState.decrement:
            return codeS(
              FActionStateDecrement.toCode(pageId, context, stateName),
              context,
            );

          case ActionState.changeWith:
            return codeS(
              FActionStateChangeWith.toCode(
                pageId: pageId,
                context: context,
                stateName: stateName,
                valueToChangeWith: valueTextTypeInput,
                loop: loop,
                isValueDefault: withValue,
              ),
              context,
            );
          case ActionState.pickFile:
            return codeS(
              FActionStateFilePicker.toCode(
                pageId: pageId,
                context: context,
                stateName: stateName,
                loop: loop,
              ),
              context,
            );
          case ActionState.changeWithParams:
            return codeS(
              FActionStateChangeWithParam.toCode(
                pageId,
                context,
                stateName,
                this.value,
              ),
              context,
            );
          case ActionState.emailValidator:
            return codeS(
              FActionEmailValidator.toCode(
                pageId: pageId,
                context: context,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context,
            );
          case ActionState.passwordValidator:
            return codeS(
              FActionPasswordValidator.toCode(
                pageId: pageId,
                context: context,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context,
            );
          case ActionState.websiteValidator:
            return codeS(
              FActionWebsiteValidator.toCode(
                pageId: pageId,
                context: context,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context,
            );
          case ActionState.phoneValidator:
            return codeS(
              FActionPhoneValidator.toCode(
                pageId: pageId,
                context: context,
                stateName: stateName,
                stateName2: stateName2,
              ),
              context,
            );
          case null:
            return '';
          default:
            return '';
        }
      case ActionType.navigation:
        switch (actionNavigation) {
          case ActionNavigation.goBack:
            return codeS(
              FActionNavigationGoBack.toCode(),
              context,
            );

          case ActionNavigation.openDrawer:
            return codeS(
              FActionNavigationOpenDrawer.toCode(),
              context,
            );
          case ActionNavigation.openPage:
            return codeS(
              FActionNavigationOpenPage.toCode(
                context,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );
          case ActionNavigation.launchURL:
            return codeS(
              FActionNavigationLaunchURL.toCode(
                valueTextTypeInput ?? FTextTypeInput(),
                loop,
              ),
              context,
            );
          case ActionNavigation.share:
            return codeS(
              FActionNavigationShare.toCode(
                valueTextTypeInput ?? FTextTypeInput(),
                loop,
              ),
              context,
            );
          case ActionNavigation.openBottomSheet:
            return codeS(
              FActionNavigationOpenBottomSheet.toCode(
                context,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionNavigation.openSnackBar:
            return codeS(
              FActionNavigationOpenSnackBar.toCode(
                context,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );
          case ActionNavigation.openDatePicker:
            return codeS(
              FActionNavigationOpenDatePicker.toCode(context, stateName),
              context,
            );
          case ActionNavigation.inAppReview:
            return codeS(
              FActionNavigationInAppReview.toCode(),
              context,
            );
          case null:
            return '';
          default:
            return '';
        }
      case ActionType.supabaseAuth:
        switch (actionSupabaseAuth) {
          case ActionSupabaseAuth.signUp:
            return codeS(
              FASupabaseSignUp.toCode(context, nameOfPage, paramsToSend),
              context,
            );
          case ActionSupabaseAuth.signInWithCredential:
            return codeS(
              FASupabaseSignInWithCredentials.toCode(
                context,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithGoogle:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.google,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithApple:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.apple,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithFacebook:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.facebook,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithDiscord:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.discord,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithAzure:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.azure,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithBitbucket:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.bitbucket,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithGitHub:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.github,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithGitLab:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.gitlab,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithSlack:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.slack,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithSpotify:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.spotify,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithTwitch:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.twitch,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithTwitter:
            return codeS(
              FASupabaseSignInWithProvider.toCode(
                context,
                Provider.twitter,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case null:
            return '';
        }
      case ActionType.supabaseStorage:
        switch (actionSupabaseStorage) {
          case ActionSupabaseStorage.upload:
            return codeS(
              FASupabaseStorageUpload.toCode(
                context,
                dbFrom,
                valueTextTypeInput,
                stateName ?? '',
                stateName2 ?? '',
                loop,
              ),
              context,
            );
          case ActionSupabaseStorage.remove:
            return codeS(
              FASupabaseStorageRemove.toCode(
                context,
                dbFrom,
                valueTextTypeInput,
                loop,
              ),
              context,
            );
          case null:
            return '';
        }
      case ActionType.supabaseFunctions:
        switch (actionSupabaseFunctions) {
          case ActionSupabaseFunctions.invoke:
            return codeS(
              FASupabaseFunctionsInvoke.toCode(
                context,
                dbFrom,
                customHttpRequestBody,
                customHttpRequestHeader,
              ),
              context,
            );
          case null:
            return '';
        }
      case ActionType.supabaseDatabase:
        switch (actionSupabaseDB) {
          case ActionSupabaseDB.insert:
            return codeS(
              FASupabaseInsert.toCode(
                context,
                nameOfPage,
                paramsToSend,
                dbFrom,
                dbData,
              ),
              context,
            );

          case ActionSupabaseDB.delete:
            return codeS(
              FASupabaseDelete.toCode(
                context,
                nameOfPage,
                paramsToSend,
                dbFrom,
                dbEq,
              ),
              context,
            );

          case ActionSupabaseDB.update:
            return codeS(
              FASupabaseUpdate.toCode(
                context,
                nameOfPage,
                paramsToSend,
                dbFrom,
                dbData,
                dbEq,
              ),
              context,
            );
          //todo: adjust this
          // case ActionSupabaseDB.onAll:
          //   return '';
          // case ActionSupabaseDB.onInsert:
          //   return '';
          // case ActionSupabaseDB.onUpdate:
          //   return '';
          // case ActionSupabaseDB.onDelete:
          //   return '';

          case null:
            return '';
          default:
            return '';
        }

      case ActionType.airtable:
        switch (actionAirtableDB) {
          case ActionAirtableDB.insert:
            return codeS(
              FAAirtableInsert.toCode(
                context,
                valueTextTypeInput,
                dbData ?? [],
              ),
              context,
            );
          case ActionAirtableDB.delete:
            return codeS(
              FAAirtableDelete.toCode(
                context,
                valueTextTypeInput,
                dbData ?? [],
              ),
              context,
            );
          case ActionAirtableDB.update:
            return codeS(
              FAAirtableUpdate.toCode(
                context,
                valueTextTypeInput,
                dbData ?? [],
              ),
              context,
            );
          case null:
            break;
        }
        break;

      case ActionType.camera:
        switch (actionCamera) {
          case ActionCamera.takePhoto:
            return codeS(
              FACameraTakePhoto.toCode(pageId, context, stateName),
              context,
            );

          case ActionCamera.switchCamera:
            return codeS(
              FACameraSwitch.toCode(
                context,
                pageId,
                stateName,
                paramsToSend,
              ),
              context,
            );

          case ActionCamera.offFlash:
            return codeS(
              FACameraOffFlash.toCode(context, pageId),
              context,
            );

          case ActionCamera.alwaysFlash:
            return codeS(
              FACameraAlwaysFlash.toCode(context, pageId),
              context,
            );

          case ActionCamera.autoFlash:
            break;
          case ActionCamera.torchFlash:
            break;
          case ActionCamera.toggleRecording:
            break;
          case null:
            return '';
        }
        break;
      case ActionType.webview:
        switch (actionWebView) {
          case ActionWebView.navigateTo:
            return codeS(
              FActionWebViewNavigateTo.toCode(
                pageId,
                context,
                stateName,
                valueTextTypeInput ?? FTextTypeInput(),
                loop,
              ),
              context,
            );

          case ActionWebView.goBack:
            return codeS(
              FActionWebViewBack.toCode(pageId, context, stateName),
              context,
            );

          case ActionWebView.goForward:
            return codeS(
              FActionWebViewForward.toCode(pageId, context, stateName),
              context,
            );

          case ActionWebView.reload:
            return codeS(
              FActionWebViewReload.toCode(pageId, context, stateName),
              context,
            );

          case null:
            return '';
        }
      case ActionType.audioPlayer:
        switch (actionAudioPlayer) {
          case ActionAudioPlayerActions.pause:
            return codeS(
              FAudioPlayerPause.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayerActions.play:
            return codeS(
              FAudioPlayerPlay.toCode(
                pageId,
                context,
                stateName,
              ),
              context,
            );

          case ActionAudioPlayerActions.playNextTrack:
            return codeS(
              FAudioPlayerPlayNextTrack.toCode(
                pageId,
                context,
                stateName,
              ),
              context,
            );

          case ActionAudioPlayerActions.playPreviousTrack:
            return codeS(
              FAudioPlayerPlayPreviousTrack.toCode(
                pageId,
                context,
                stateName,
              ),
              context,
            );
          case ActionAudioPlayerActions.reload:
            return codeS(
              FAudioPlayerReload.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayerActions.loopOff:
            return codeS(
              FAudioPlayerLoopOff.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayerActions.loopOne:
            return codeS(
              FAudioPlayerLoopOne.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayerActions.loopAll:
            return codeS(
              FAudioPlayerLoopAll.toCode(pageId, context, stateName),
              context,
            );

          case null:
            return '';
        }
      case null:
        return '';
      case ActionType.shopify:
        break;
      case ActionType.firebase:
        break;
      case ActionType.firebaseFirestore:
        break;
      case ActionType.firebaseStorage:
        break;
    }
    return '';
  }

  Future<void> actionS(
    final Function() func, {
    required final BuildContext context,
    required final TetaWidgetState state,
  }) async {
    if (withCondition == true) {
      if (condition?.get(
            state.params,
            state.states,
            state.dataset,
            true,
            state.loop,
            context,
          ) !=
          valueOfCondition?.get(
            state.params,
            state.states,
            state.dataset,
            true,
            state.loop,
            context,
          )) {
        return;
      }
    }
    await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
    FLoop.action(
      func,
      everyMilliseconds,
      context,
      withLoop: withLoop ?? false,
    );
  }

  String codeS(final String func, final BuildContext context) => AS.toCode(
        func,
        context: context,
        condition: condition,
        valueOfCondition: valueOfCondition,
        withCondition: withCondition,
        everyMilliseconds: everyMilliseconds,
        delay: delay,
        withLoop: withLoop,
      );
}
