// ignore_for_file: public_member_api_docs, must_be_immutable, avoid_bool_literals_in_conditional_expressions

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_core/src/models/supabase_map_element.dart';
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
import 'package:teta_widgets/src/elements/actions/supabase/delete.dart';
import 'package:teta_widgets/src/elements/actions/supabase/insert.dart';
import 'package:teta_widgets/src/elements/actions/supabase/on_all.dart';
import 'package:teta_widgets/src/elements/actions/supabase/on_delete.dart';
import 'package:teta_widgets/src/elements/actions/supabase/on_insert.dart';
import 'package:teta_widgets/src/elements/actions/supabase/on_update.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_apple.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_credentials.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_facebook.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_google.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signup_w_credentials.dart';
import 'package:teta_widgets/src/elements/actions/supabase/update.dart';
import 'package:teta_widgets/src/elements/actions/webview/back.dart';
import 'package:teta_widgets/src/elements/actions/webview/forward.dart';
import 'package:teta_widgets/src/elements/actions/webview/reload.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/audio_player.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/camera.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/revenue_cat.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/stripe.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/webview.dart';
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
    this.supabaseFrom,
    this.supabaseData,
    this.supabaseEq,
    this.withCondition,
    this.condition,
    this.valueOfCondition,
    this.withLoop,
    this.everyMilliseconds,
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
    stateName = doc['sN'] as String?;
    nameOfPage = doc['pN'] as String?;
    paramsToSend = doc['pTS'] as Map<String, dynamic>?;
    value = doc['v'] as String?;
    supabaseFrom =
        FTextTypeInput.fromJson(doc['sFrom'] as Map<String, dynamic>?);
    supabaseData = (doc['sData'] as List<dynamic>? ?? <dynamic>[])
        .map(
          (final dynamic e) => SupabaseMapElement.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
    supabaseEq = doc['sEq'] != null
        ? SupabaseMapElement.fromJson(doc['sEq'] as Map<String, dynamic>)
        : SupabaseMapElement(
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
  ActionSupabaseAuth? actionSupabaseAuth;
  ActionSupabaseDB? actionSupabaseDB;
  ActionCamera? actionCamera;
  ActionWebView? actionWebView;
  ActionAudioPlayer? actionAudioPlayer;
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

  /// Supabase from
  FTextTypeInput? supabaseFrom;

  /// Supabase data for insert / update map
  List<SupabaseMapElement>? supabaseData;

  /// Supabase name of column for condition
  SupabaseMapElement? supabaseEq;

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
      ];

  /// Get avaiable action types for drop down list
  List<String> getTypes(final ProjectConfig? config, final PageObject page) {
    if (config != null) {
      try {
        return [
          'State',
          'Navigation',
          if (config.supabaseEnabled ?? false) 'Supabase auth',
          if (config.supabaseEnabled ?? false) 'Supabase database',
          if (config.isRevenueCatEnabled) 'RevenueCat',
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
        'aN': convertValueToDropdown(actionNavigation),
        'aS': convertValueToDropdown(actionState),
        'g': convertValueToDropdown(actionGesture),
        'sA': convertValueToDropdown(actionSupabaseAuth),
        'sD': convertValueToDropdown(actionSupabaseDB),
        'aC': convertValueToDropdown(actionCamera),
        'aW': convertValueToDropdown(actionWebView),
        'aAP': convertValueToDropdown(actionAudioPlayer),
        'aRC': convertValueToDropdown(actionRevenueCat),
        'sPK':convertValueToDropdown(actionStripe),
        'sN': stateName,
        'pTS': paramsToSend,
        'pN': nameOfPage,
        'v': value,
        'sFrom': supabaseFrom != null ? supabaseFrom!.toJson() : null,
        'sData': supabaseData != null
            ? supabaseData!.map((final e) => e.toJson()).toList()
            : null,
        'sEq': supabaseEq != null ? supabaseEq!.toJson() : null,
        'delay': delay != null ? delay!.toJson() : null,
        'wCond': withCondition,
        'cond': condition != null ? condition!.toJson() : null,
        'vCond': valueOfCondition != null ? valueOfCondition!.toJson() : null,
        'wLoop': withLoop,
        'evrMll':
            everyMilliseconds != null ? everyMilliseconds!.toJson() : null,
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
      case ActionType.revenueCat:
        switch (actionRevenueCat) {
          case ActionRevenueCat.buy:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionRevenueCatBuy.action(context, states, stateName),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.stripe:
        switch (actionStripe) {
          case ActionStripe.buy:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionStripeBuy.action(context, states, stateName),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          default:
            break;
        }
        break;
      case ActionType.state:
        switch (actionState) {
          case ActionState.increment:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionStateIncrement.action(context, states, stateName),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionState.decrement:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionStateDecrement.action(context, states, stateName),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionState.changeWith:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionStateChangeWith.action(
                context,
                states,
                stateName,
                value ?? this.value,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionState.changeWithParams:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionStateChangeWithParam.action(
                context,
                states,
                params,
                stateName,
                this.value,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.navigation:
        switch (actionNavigation) {
          case ActionNavigation.goBack:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionNavigationGoBack.action(context),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionNavigation.openDrawer:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionNavigationOpenDrawer.action(context),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionNavigation.openPage:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
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
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionNavigation.launchURL:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionNavigationLaunchURL.action(context, this.value),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionNavigation.openBottomSheet:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionNavigationOpenBottomSheet.action(
                context,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionNavigation.openSnackBar:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionNavigationOpenSnackBar.action(
                context,
                nameOfPage,
                paramsToSend,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionNavigation.openDatePicker:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionNavigationOpenDatePicker.action(
                context,
                states,
                stateName,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.supabaseAuth:
        switch (actionSupabaseAuth) {
          case ActionSupabaseAuth.signUp:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
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
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseAuth.signInWithCredential:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
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
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseAuth.signInWithGoogle:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
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
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseAuth.signInWithApple:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
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
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseAuth.signInWithFacebook:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
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
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.supabaseDatabase:
        switch (actionSupabaseDB) {
          case ActionSupabaseDB.insert:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FASupabaseInsert.action(
                context,
                supabaseFrom,
                supabaseData,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseDB.update:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FASupabaseUpdate.action(
                context,
                supabaseFrom,
                supabaseData,
                supabaseEq ??
                    SupabaseMapElement(key: '', value: FTextTypeInput()),
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseDB.delete:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FASupabaseDelete.action(
                context,
                supabaseFrom,
                supabaseEq ??
                    SupabaseMapElement(key: '', value: FTextTypeInput()),
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseDB.onAll:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FASupabaseOnAll.action(
                context,
                supabaseFrom,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseDB.onInsert:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FASupabaseOnInsert.action(
                context,
                supabaseFrom,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseDB.onUpdate:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FASupabaseOnUpdate.action(
                context,
                supabaseFrom,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionSupabaseDB.onDelete:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FASupabaseOnDelete.action(
                context,
                supabaseFrom,
                stateName,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.camera:
        switch (actionCamera) {
          case ActionCamera.takePhoto:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FACameraTakePhoto.action(
                context,
                stateName,
                supabaseData,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionCamera.switchCamera:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FACameraSwitch.action(
                context,
                stateName,
                supabaseData,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionCamera.offFlash:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FACameraOffFlash.action(
                context,
                stateName,
                supabaseData,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionCamera.alwaysFlash:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FACameraAlwaysFlash.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionCamera.autoFlash:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FACameraAutoFlash.action(
                context,
                stateName,
                supabaseData,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionCamera.torchFlash:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FACameraTorchFlash.action(
                context,
                stateName,
                supabaseData,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionCamera.toggleRecording:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FACameraStopRecording.action(
                context,
                stateName,
                supabaseData,
                params,
                states,
                dataset,
                loop,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;

          case null:
            break;
        }
        break;
      case ActionType.webview:
        switch (actionWebView) {
          case ActionWebView.goBack:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionWebViewBack.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionWebView.reload:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionWebViewReload.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionWebView.goForward:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FActionWebViewForward.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case null:
            break;
        }
        break;
      case ActionType.audioPlayer:
        switch (actionAudioPlayer) {
          case ActionAudioPlayer.play:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FAudioPlayerPlay.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionAudioPlayer.pause:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FAudioPlayerPause.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionAudioPlayer.reload:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FAudioPlayerReload.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionAudioPlayer.loopOff:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FAudioPlayerLoopOff.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionAudioPlayer.loopOne:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FAudioPlayerLoopOne.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
            );
            break;
          case ActionAudioPlayer.loopAll:
            if (withCondition == true) {
              if (condition?.get(params, states, dataset, true, loop) !=
                  valueOfCondition?.get(params, states, dataset, true, loop)) {
                break;
              }
            }
            await FDelay.action(int.tryParse('${delay?.value}') ?? 0);
            FLoop.action(
              () => FAudioPlayerLoopAll.action(
                context,
                states,
                stateName,
              ),
              everyMilliseconds,
              context,
              withLoop: withLoop ?? false,
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

  String toCode(
    final String? value,
    final BuildContext context,
    final CNode body,
  ) {
    switch (actionType) {
      case ActionType.revenueCat:
        switch (actionRevenueCat) {
          case ActionRevenueCat.buy:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionRevenueCatBuy.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );
          default:
            break;
        }
        break;
      case ActionType.stripe:
        switch (actionStripe) {
          case ActionStripe.buy:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionStripeBuy.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );
          default:
            break;
        }
        break;

      case ActionType.state:
        switch (actionState) {
          case ActionState.increment:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionStateIncrement.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionState.decrement:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionStateDecrement.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionState.changeWith:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionStateChangeWith.toCode(
                    context,
                    stateName,
                    value ?? this.value,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionState.changeWithParams:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionStateChangeWithParam.toCode(
                    context,
                    stateName,
                    this.value,
                  ),
                  withLoop: withLoop ?? false,
                );
          case null:
            return '';
        }
      case ActionType.navigation:
        switch (actionNavigation) {
          case ActionNavigation.goBack:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionNavigationGoBack.toCode(),
                  withLoop: withLoop ?? false,
                );

          case ActionNavigation.openDrawer:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionNavigationOpenDrawer.toCode(),
                  withLoop: withLoop ?? false,
                );
          case ActionNavigation.openPage:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionNavigationOpenPage.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionNavigation.launchURL:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionNavigationLaunchURL.toCode(value),
                  withLoop: withLoop ?? false,
                );

          case ActionNavigation.openBottomSheet:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionNavigationOpenBottomSheet.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionNavigation.openSnackBar:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionNavigationOpenSnackBar.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionNavigation.openDatePicker:
            return '';
          case null:
            return '';
        }
      case ActionType.supabaseAuth:
        switch (actionSupabaseAuth) {
          case ActionSupabaseAuth.signUp:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseSignUp.toCode(context, nameOfPage, paramsToSend),
                  withLoop: withLoop ?? false,
                );
          case ActionSupabaseAuth.signInWithCredential:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseSignInWithCredentials.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionSupabaseAuth.signInWithGoogle:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseSignInWithGoogle.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionSupabaseAuth.signInWithApple:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseSignInWithApple.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionSupabaseAuth.signInWithFacebook:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseSignInWithFacebook.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                  ),
                  withLoop: withLoop ?? false,
                );

          case null:
            return '';
        }
      case ActionType.supabaseDatabase:
        switch (actionSupabaseDB) {
          case ActionSupabaseDB.insert:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseInsert.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                    supabaseFrom,
                    supabaseData,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionSupabaseDB.delete:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseDelete.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                    supabaseFrom,
                    supabaseEq,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionSupabaseDB.update:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FASupabaseUpdate.toCode(
                    context,
                    nameOfPage,
                    paramsToSend,
                    supabaseFrom,
                    supabaseData,
                    supabaseEq,
                  ),
                  withLoop: withLoop ?? false,
                );

          case ActionSupabaseDB.onAll:
            return '';
          case ActionSupabaseDB.onInsert:
            return '';
          case ActionSupabaseDB.onUpdate:
            return '';
          case ActionSupabaseDB.onDelete:
            return '';
          case null:
            return '';
        }
      case ActionType.camera:
        switch (actionCamera) {
          case ActionCamera.takePhoto:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FACameraTakePhoto.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionCamera.switchCamera:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FACameraSwitch.toCode(context, stateName, paramsToSend),
                  withLoop: withLoop ?? false,
                );

          case ActionCamera.offFlash:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FACameraOffFlash.toCode(context, stateName, paramsToSend),
                  withLoop: withLoop ?? false,
                );

          case ActionCamera.alwaysFlash:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FACameraAlwaysFlash.toCode(context, nameOfPage, paramsToSend),
                  withLoop: withLoop ?? false,
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
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionWebViewBack.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionWebView.goForward:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionWebViewForward.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionWebView.reload:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FActionWebViewReload.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case null:
            return '';
        }
      case ActionType.audioPlayer:
        switch (actionAudioPlayer) {
          case ActionAudioPlayer.pause:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FAudioPlayerPause.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionAudioPlayer.play:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FAudioPlayerPlay.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionAudioPlayer.reload:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FAudioPlayerReload.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionAudioPlayer.loopOff:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FAudioPlayerLoopOff.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionAudioPlayer.loopOne:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FAudioPlayerLoopOne.toCode(context, stateName),
                  withLoop: withLoop ?? false,
                );

          case ActionAudioPlayer.loopAll:
            return FCondition.toCode(
                  context,
                  condition,
                  valueOfCondition,
                  withCondition: withCondition ?? false,
                ) +
                FDelay.toCode(int.tryParse('${delay?.value}') ?? 0) +
                FLoop.toCode(
                  int.tryParse(everyMilliseconds?.value ?? '0') ?? 0,
                  FAudioPlayerLoopAll.toCode(context, stateName),
                  withLoop: withLoop ?? false,
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
}
