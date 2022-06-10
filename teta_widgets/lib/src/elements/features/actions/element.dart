// ignore_for_file: public_member_api_docs, must_be_immutable, avoid_bool_literals_in_conditional_expressions

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/map_element.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/audio_player/loop_all.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/loop_off.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/loop_one.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/pause.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/play.dart';
import 'package:teta_widgets/src/elements/actions/audio_player/reload.dart';
import 'package:teta_widgets/src/elements/actions/camera/always_flash.dart';
import 'package:teta_widgets/src/elements/actions/camera/auto_flash.dart';
import 'package:teta_widgets/src/elements/actions/camera/off_flash.dart';
import 'package:teta_widgets/src/elements/actions/camera/stop_recording.dart';
import 'package:teta_widgets/src/elements/actions/camera/switch_camera.dart';
import 'package:teta_widgets/src/elements/actions/camera/take_photo.dart';
import 'package:teta_widgets/src/elements/actions/camera/torch_flash.dart';
import 'package:teta_widgets/src/elements/actions/condition.dart';
import 'package:teta_widgets/src/elements/actions/custom_functions/custom_function.dart';
import 'package:teta_widgets/src/elements/actions/delay.dart';
import 'package:teta_widgets/src/elements/actions/loop.dart';
import 'package:teta_widgets/src/elements/actions/navigation/go_back.dart';
import 'package:teta_widgets/src/elements/actions/navigation/launch_url.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_bottom_sheet.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_date_picker.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_drawer.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_snack.dart';
import 'package:teta_widgets/src/elements/actions/revenue_cat/buy.dart';
import 'package:teta_widgets/src/elements/actions/state/change_with.dart';
import 'package:teta_widgets/src/elements/actions/state/change_with_param.dart';
import 'package:teta_widgets/src/elements/actions/state/decrement.dart';
import 'package:teta_widgets/src/elements/actions/state/increment.dart';
import 'package:teta_widgets/src/elements/actions/stripe/buy.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_add_list_item_to_cart.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_cart_buy_all.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_cart_remove_list_item_from_cart.dart';
import 'package:teta_widgets/src/elements/actions/stripe/stripe_remove_list_item_to_cart.dart';
import 'package:teta_widgets/src/elements/actions/supabase/delete.dart';
import 'package:teta_widgets/src/elements/actions/supabase/insert.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_apple.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_credentials.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_facebook.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_google.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signup_w_credentials.dart';
import 'package:teta_widgets/src/elements/actions/supabase/update.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/auth/login.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/auth/logout.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/database/delete.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/database/insert.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/database/update.dart';
import 'package:teta_widgets/src/elements/actions/webview/back.dart';
import 'package:teta_widgets/src/elements/actions/webview/forward.dart';
import 'package:teta_widgets/src/elements/actions/webview/reload.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/audio_player.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/camera.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/revenue_cat.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/stripe.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/teta_cms.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/webview.dart';
import 'package:teta_widgets/src/elements/features/actions/snippets.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:uuid/uuid.dart';

class FActionElement extends Equatable {
  FActionElement({
    this.id,
    this.actionRevenueCat,
    this.actionStripe,
    this.actionType,
    this.actionGesture,
    this.actionNavigation,
    this.actionState,
    this.customFunctionId,
    this.actionSupabaseAuth,
    this.actionSupabaseDB,
    this.actionCamera,
    this.actionWebView,
    this.actionAudioPlayer,
    this.prodId,
    this.stateName,
    this.nameOfPage,
    this.paramsToSend,
    this.value,
    this.delay,
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
  }) {
    id ??= const Uuid().v1();
    delay ??= FTextTypeInput(value: '0');
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
    actionRevenueCat =
        convertDropdownToValue(ActionRevenueCat.values, doc['aRC'] as String?)
            as ActionRevenueCat?;
    actionStripe =
        convertDropdownToValue(ActionStripe.values, doc['sPK'] as String?)
            as ActionStripe?;
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
    actionCamera =
        convertDropdownToValue(ActionCamera.values, doc['aC'] as String?)
            as ActionCamera?;
    actionWebView =
        convertDropdownToValue(ActionWebView.values, doc['aW'] as String?)
            as ActionWebView?;
    actionAudioPlayer =
        convertDropdownToValue(ActionAudioPlayer.values, doc['aAP'] as String?)
            as ActionAudioPlayer?;
    actionTetaDB =
        convertDropdownToValue(ActionTetaCmsDB.values, doc['aTDb'] as String?)
            as ActionTetaCmsDB?;
    actionTetaAuth =
        convertDropdownToValue(ActionTetaCmsAuth.values, doc['aTAu'] as String?)
            as ActionTetaCmsAuth?;
    stateName = doc['sN'] as String?;
    nameOfPage = doc['pN'] as String?;
    paramsToSend = doc['pTS'] as Map<String, dynamic>?;
    valueTextTypeInput =
        doc['v'] != null ? FTextTypeInput(value: doc['v'] as String?) : null;
    valueTextTypeInput = valueTextTypeInput ??
        (doc['vTTI'] != null
            ? FTextTypeInput.fromJson(doc['vTTI'] as Map<String, dynamic>)
            : FTextTypeInput());
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
  }

  String? id;
  ActionType? actionType;
  ActionGesture? actionGesture;
  ActionNavigation? actionNavigation;
  ActionState? actionState;
  ActionRevenueCat? actionRevenueCat;
  ActionStripe? actionStripe;
  int? customFunctionId;
  ActionSupabaseAuth? actionSupabaseAuth;
  ActionSupabaseDB? actionSupabaseDB;
  ActionCamera? actionCamera;
  ActionWebView? actionWebView;
  ActionAudioPlayer? actionAudioPlayer;
  ActionTetaCmsDB? actionTetaDB;
  ActionTetaCmsAuth? actionTetaAuth;
  FTextTypeInput? delay;
  bool? withCondition;
  FTextTypeInput? condition;
  FTextTypeInput? valueOfCondition;
  bool? withLoop;
  FTextTypeInput? everyMilliseconds;

  String? prodId;
  String? stateName;
  String? nameOfPage;
  String? nameOfDataset;
  Map<String, dynamic>? paramsToSend;
  String? value;
  FTextTypeInput? valueTextTypeInput;

  /// Supabase from
  FTextTypeInput? dbFrom;
  String? cmsCollectionId;

  /// Supabase data for insert / update map
  List<MapElement>? dbData;

  /// Supabase name of column for condition
  MapElement? dbEq;

  @override
  List<Object?> get props => [
        id,
        actionType,
        actionGesture,
        actionNavigation,
        actionState,
        actionWebView,
        stateName,
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
          if (kDebugMode) 'Custom Functions',
          if (config.supabaseEnabled ?? false) 'Supabase auth',
          if (config.supabaseEnabled ?? false) 'Supabase database',
          if (kDebugMode)
            if (config.isRevenueCatEnabled) 'RevenueCat',
          if (kDebugMode)
            if (config.isStripeEnabled) 'Stripe',
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

  static List<String> getStripe(final ProjectConfig? config) {
    if (config != null) {
      if (config.isStripeEnabled) {
        return enumsToListString(ActionStripe.values);
      }
    }
    return [];
  }

  static List<String> getSupabaseAuth(final ProjectConfig? config) {
    if (config != null) {
      if (config.supabaseEnabled ?? false) {
        return enumsToListString(ActionSupabaseAuth.values);
      }
    }
    return [];
  }

  static List<String> getSupabaseDB(final ProjectConfig? config) {
    if (config != null) {
      if (config.supabaseEnabled ?? false) {
        return enumsToListString(ActionSupabaseDB.values);
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

  static List<String> getCamera() {
    return enumsToListString(ActionCamera.values);
  }

  static List<String> getWebView() {
    return enumsToListString(ActionWebView.values);
  }

  static List<String> getAudioPlayer() {
    return enumsToListString(ActionAudioPlayer.values);
  }

  static String? convertValueToDropdown(final dynamic type) {
    if (type == ActionType.revenueCat) {
      return 'RevenueCat';
    }
    if (type == ActionType.stripe) {
      return 'Stripe';
    }
    if (type == ActionType.customFunctions) {
      return 'Custom Functions';
    }
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
    if (value == 'Stripe') {
      return ActionType.stripe;
    }
    if (value == 'Custom Functions') {
      return ActionType.customFunctions;
    }
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
        'aS': convertValueToDropdown(actionState),
        'g': convertValueToDropdown(actionGesture),
        'sA': convertValueToDropdown(actionSupabaseAuth),
        'sD': convertValueToDropdown(actionSupabaseDB),
        'aC': convertValueToDropdown(actionCamera),
        'aW': convertValueToDropdown(actionWebView),
        'aAP': convertValueToDropdown(actionAudioPlayer),
        'aRC': convertValueToDropdown(actionRevenueCat),
        'sPK': convertValueToDropdown(actionStripe),
        'aTDb': convertValueToDropdown(actionTetaDB),
        'aTAu': convertValueToDropdown(actionTetaAuth),
        'sN': stateName,
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
        'wCond': withCondition,
        'cond': condition != null ? condition!.toJson() : null,
        'vCond': valueOfCondition != null ? valueOfCondition!.toJson() : null,
        'wLoop': withLoop,
        'evrMll':
            everyMilliseconds != null ? everyMilliseconds!.toJson() : null,
        'vTTI':
            valueTextTypeInput != null ? valueTextTypeInput!.toJson() : null,
      }..removeWhere((final String key, final dynamic value) => value == null);

  Future getAction(
    final BuildContext context,
    final String? value,
    final CNode scaffold,
    final CNode node,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    switch (actionType) {
      case ActionType.customFunctions:
        if (withCondition == true) {
          if (condition?.get(params, states, dataset, true, loop) !=
              valueOfCondition?.get(params, states, dataset, true, loop)) {
            break;
          }
        }
        await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
        FLoop.action(
          () => FActionCustomFunction.action(
            context,
            loop,
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
                cmsCollectionId,
                dbData,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionTetaCmsDB.update:
            await actionS(
              () => FATetaCMSUpdate.action(
                cmsCollectionId,
                dbData,
                dbFrom,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionTetaCmsDB.delete:
            await actionS(
              () => FATetaCMSDelete.action(
                cmsCollectionId,
                dbFrom,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
        }
        break;
      case ActionType.tetaAuth:
        switch (actionTetaAuth) {
          case ActionTetaCmsAuth.signInWithGoogle:
            await actionS(
              () => FATetaCMSLogin.action(
                node,
                nameOfPage,
                context,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
                TetaProvider.google,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionTetaCmsAuth.signInWithGitHub:
            await actionS(
              () => FATetaCMSLogin.action(
                node,
                nameOfPage,
                context,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
                TetaProvider.github,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionTetaCmsAuth.signInWithTwitter:
            await actionS(
              () => FATetaCMSLogin.action(
                node,
                nameOfPage,
                context,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
                TetaProvider.twitter,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionTetaCmsAuth.signInWithApple:
            await actionS(
              () => FATetaCMSLogin.action(
                node,
                nameOfPage,
                context,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
                TetaProvider.apple,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionTetaCmsAuth.logout:
            await actionS(
              () => FATetaCMSLogout.action(
                context,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
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
              () => FActionRevenueCatBuy.action(context, states, stateName),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.stripe:
        switch (actionStripe) {
          case ActionStripe.buy:
            await actionS(
              () => FActionStripeBuy.action(
                context,
                states,
                stateName,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionStripe.buyCartItems:
            await actionS(
              () => FActionStripeCartBuyAll.action(
                context,
                states,
                stateName,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionStripe.addProductsListItemToCart:
            await actionS(
              () => FActionStripeAddProductsListItemToCart.action(
                context,
                states,
                stateName,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionStripe.removeProductsListItemFromCart:
            await actionS(
              () => FActionStripeRemoveProductsListItemFromCart.action(
                context,
                states,
                stateName,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionStripe.removeCartListItemFromCart:
            await actionS(
              () => FActionStripeCartRemoveProductsListItemFromCart.action(
                context,
                states,
                stateName,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
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
              () => FActionStateIncrement.action(context, states, stateName),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionState.decrement:
            await actionS(
              () => FActionStateDecrement.action(context, states, stateName),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionState.changeWith:
            await actionS(
              () => FActionStateChangeWith.action(
                context: context,
                states: states,
                params: params,
                datasets: dataset,
                stateName: stateName,
                valueToChangeWith: valueTextTypeInput ?? FTextTypeInput(),
                value: value,
                loop: loop ?? 0,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionState.changeWithParams:
            await actionS(
              () => FActionStateChangeWithParam.action(
                context,
                states,
                params,
                stateName,
                this.value,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
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
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionNavigation.openDrawer:
            await actionS(
              () => FActionNavigationOpenDrawer.action(context),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionNavigation.openPage:
            await actionS(
              () => FActionNavigationOpenPage.action(
                node,
                context,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionNavigation.launchURL:
            await actionS(
              () => FActionNavigationLaunchURL.action(
                context: context,
                params: params,
                states: states,
                datasets: dataset,
                loop: loop ?? 0,
                value: valueTextTypeInput ?? FTextTypeInput(),
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionNavigation.openBottomSheet:
            await actionS(
              () => FActionNavigationOpenBottomSheet.action(
                context,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionNavigation.openSnackBar:
            await actionS(
              () => FActionNavigationOpenSnackBar.action(
                context,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionNavigation.openDatePicker:
            await actionS(
              () => FActionNavigationOpenDatePicker.action(
                context,
                states,
                stateName,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.supabaseAuth:
        switch (actionSupabaseAuth) {
          case ActionSupabaseAuth.signUp:
            await actionS(
              () => FASupabaseSignUp.action(
                context,
                value ?? this.value ?? '',
                scaffold,
                node,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionSupabaseAuth.signInWithCredential:
            await actionS(
              () => FASupabaseSignInWithCredentials.action(
                context,
                value ?? this.value ?? '',
                scaffold,
                node,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionSupabaseAuth.signInWithGoogle:
            await actionS(
              () => FASupabaseSignInWithGoogle.action(
                context,
                value ?? this.value ?? '',
                scaffold,
                node,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionSupabaseAuth.signInWithApple:
            await actionS(
              () => FASupabaseSignInWithApple.action(
                context,
                value ?? this.value ?? '',
                scaffold,
                node,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionSupabaseAuth.signInWithFacebook:
            await actionS(
              () => FASupabaseSignInWithFacebook.action(
                context,
                value ?? this.value ?? '',
                scaffold,
                node,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
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
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionCamera.switchCamera:
            await actionS(
              () => FACameraSwitch.action(
                context,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionCamera.offFlash:
            await actionS(
              () => FACameraOffFlash.action(
                context,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionCamera.alwaysFlash:
            await actionS(
              () => FACameraAlwaysFlash.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionCamera.autoFlash:
            await actionS(
              () => FACameraAutoFlash.action(
                context,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionCamera.torchFlash:
            await actionS(
              () => FACameraTorchFlash.action(
                context,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionCamera.toggleRecording:
            await actionS(
              () => FACameraStopRecording.action(
                context,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;

          case null:
            break;
        }
        break;
      case ActionType.webview:
        switch (actionWebView) {
          case ActionWebView.goBack:
            await actionS(
              () => FActionWebViewBack.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionWebView.reload:
            await actionS(
              () => FActionWebViewReload.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionWebView.goForward:
            await actionS(
              () => FActionWebViewForward.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.audioPlayer:
        switch (actionAudioPlayer) {
          case ActionAudioPlayer.play:
            await actionS(
              () => FAudioPlayerPlay.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionAudioPlayer.pause:
            await actionS(
              () => FAudioPlayerPause.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionAudioPlayer.reload:
            await actionS(
              () => FAudioPlayerReload.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );
            break;
          case ActionAudioPlayer.loopOff:
            await actionS(
              () => FAudioPlayerLoopOff.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionAudioPlayer.loopOne:
            await actionS(
              () => FAudioPlayerLoopOne.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
            );

            break;
          case ActionAudioPlayer.loopAll:
            await actionS(
              () => FAudioPlayerLoopAll.action(
                context,
                states,
                stateName,
              ),
              context: context,
              params: params,
              states: states,
              dataset: dataset,
              loop: loop,
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
    }
  }

  String toCode({
    required final int pageId,
    required final BuildContext context,
    required final CNode body,
    final String? value,
    final int loop = 0,
  }) {
    switch (actionType) {
      case ActionType.customFunctions:
        return FCondition.toCode(
              context,
              condition,
              valueOfCondition,
              withCondition: withCondition ?? false,
            ) +
            FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
            FLoop.toCode(
              int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
              FActionCustomFunction.toCode(
                context,
                customFunctionId,
              ),
              withLoop: withLoop ?? false,
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
              FActionRevenueCatBuy.toCode(context, stateName),
              context,
            );
          default:
            break;
        }
        break;
      case ActionType.stripe:
        switch (actionStripe) {
          case ActionStripe.buy:
            return codeS(
              FActionStripeBuy.toCode(context, stateName, body),
              context,
            );
          case ActionStripe.buyCartItems:
            return codeS(
              FActionStripeCartBuyAll.toCode(context, stateName, body),
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
          case ActionStripe.removeProductsListItemFromCart:
            return codeS(
              FActionStripeRemoveProductsListItemFromCart.toCode(
                context,
                stateName,
                body,
              ),
              context,
            );
          default:
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
          case null:
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
                context,
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
            return '';
          case null:
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
              FASupabaseSignInWithGoogle.toCode(
                context,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithApple:
            return codeS(
              FASupabaseSignInWithApple.toCode(
                context,
                nameOfPage,
                paramsToSend,
              ),
              context,
            );

          case ActionSupabaseAuth.signInWithFacebook:
            return codeS(
              FASupabaseSignInWithFacebook.toCode(
                context,
                nameOfPage,
                paramsToSend,
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
        }
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
                pageId,
                context,
                stateName,
                paramsToSend,
              ),
              context,
            );

          case ActionCamera.offFlash:
            return codeS(
              FACameraOffFlash.toCode(
                pageId,
                context,
                stateName,
                paramsToSend,
              ),
              context,
            );

          case ActionCamera.alwaysFlash:
            return codeS(
              FACameraAlwaysFlash.toCode(
                pageId,
                context,
                nameOfPage,
                paramsToSend,
              ),
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
          case ActionAudioPlayer.pause:
            return codeS(
              FAudioPlayerPause.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayer.play:
            return codeS(
              FAudioPlayerPlay.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayer.reload:
            return codeS(
              FAudioPlayerReload.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayer.loopOff:
            return codeS(
              FAudioPlayerLoopOff.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayer.loopOne:
            return codeS(
              FAudioPlayerLoopOne.toCode(pageId, context, stateName),
              context,
            );

          case ActionAudioPlayer.loopAll:
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
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final int? loop,
  }) async {
    if (withCondition == true) {
      if (condition?.get(params, states, dataset, true, loop) !=
          valueOfCondition?.get(params, states, dataset, true, loop)) {
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
