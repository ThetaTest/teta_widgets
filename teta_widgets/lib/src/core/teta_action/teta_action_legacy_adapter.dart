// ignore_for_file: avoid_dynamic_calls

import 'dart:core';

import 'package:teta_cms/teta_cms.dart';

import 'action_types/types.dart';

class TetaActionLegacyAdapter {
  TetaActionLegacyAdapter._();

  static Map<String, dynamic> convertLegacyJsonToNewJson(
    final Map<String, dynamic> legacyJson,
  ) {
    final json = <String, dynamic>{};

    // ID
    json['id'] = legacyJson['id'];
    json['type'] = _parseActionType(legacyJson).toString();

    // Loop
    json['loop'] = <String, dynamic>{};
    json['loop']['interval'] =
        int.tryParse(legacyJson['evrMll']['v'] as String? ?? '0') ?? 0;
    if (json['loop']['interval'] == 0) {
      json['loop'] = null;
    }

    // Condition
    json['condition'] = <String, dynamic>{};
    if (legacyJson['wCond'] != null && legacyJson['wCond'] == true) {
      json['condition']['condition'] = legacyJson['cond'];
      json['condition']['valueOfCondition'] = legacyJson['vCond'];
    } else {
      json['condition'] = null;
    }

    // Delay
    json['delay'] =
        int.tryParse(legacyJson['delay']['v'] as String? ?? '0') ?? 0;

    // Remove legacy keys
    legacyJson
      ..remove('id')
      ..remove('type')
      ..remove('evrMll')
      ..remove('wCond')
      ..remove('cond')
      ..remove('vCond')
      ..remove('delay');

    // Teta Auth Providers
    if (legacyJson.containsKey('aTAu') && legacyJson['aTAu'] != null) {
      final providerString =
          '${legacyJson['aTAu']}'.toLowerCase().split(' ').join();
      if (providerString.contains('github')) {
        legacyJson['provider'] = TetaProvider.github.toString();
      } else if (providerString.contains('google')) {
        legacyJson['provider'] = TetaProvider.google.toString();
      } else if (providerString.contains('facebook')) {
        legacyJson['provider'] = TetaProvider.facebook.toString();
      } else if (providerString.contains('apple')) {
        legacyJson['provider'] = TetaProvider.apple.toString();
      } else if (providerString.contains('twitter')) {
        legacyJson['provider'] = TetaProvider.twitter.toString();
      } else if (providerString.contains('gitlab')) {
        legacyJson['provider'] = TetaProvider.gitlab.toString();
      } else if (providerString.contains('discord')) {
        legacyJson['provider'] = TetaProvider.discord.toString();
      } else if (providerString.contains('linkedin')) {
        legacyJson['provider'] = TetaProvider.linkedin.toString();
      } else if (providerString.contains('bitbucket')) {
        legacyJson['provider'] = TetaProvider.bitbucket.toString();
      } else if (providerString.contains('twitch')) {
        legacyJson['provider'] = TetaProvider.twitch.toString();
      }
    }

    // Params
    json['params'] = legacyJson;
    return json;
  }

  static TetaActionType? _parseActionType(final Map<String, dynamic> json) {
    if (json['aT'] == 'RevenueCat') {
      if (json['aRC'] == 'Buy') {
        return TetaActionType.revenueCatBuy;
      } else if (json['aRC'] == 'Restore purchases') {
        return TetaActionType.revenueCatRestore;
      }
    } else if (json['aT'] == 'Navigation') {
      if (json['aN'] == 'Go back') {
        return TetaActionType.navigationGoBack;
      } else if (json['aN'] == 'Open drawer') {
        return TetaActionType.navigationOpenDrawer;
      } else if (json['aN'] == 'Launch url') {
        return TetaActionType.navigationLaunchUrl;
      } else if (json['aN'] == 'Open page') {
        return TetaActionType.navigationOpenPage;
      } else if (json['aN'] == 'Open bottom sheet') {
        return TetaActionType.navigationOpenBottomSheet;
      } else if (json['aN'] == 'Open date picker') {
        return TetaActionType.navigationOpenDatePicker;
      } else if (json['aN'] == 'In app review') {
        return TetaActionType.navigationInAppReview;
      } else if (json['aN'] == 'Share') {
        return TetaActionType.navigationShare;
      }
    } else if (json['aT'] == 'Mixpanel') {
      if (json['aMixpanel'] == 'Track') {
        return TetaActionType.mixpanelTrack;
      } else if (json['aMixpanel'] == 'Set user id') {
        return TetaActionType.mixpanelSetUserId;
      }
    } else if (json['aT'] == 'Qonversion') {
      if (json['aQonversion'] == 'Buy') {
        return TetaActionType.qonversionBuy;
      } else if (json['aQonversion'] == 'Restore purchases') {
        return TetaActionType.qonversionRestore;
      }
    } else if (json['aT'] == 'Camera') {
      if (json['aC'] == 'Take Photo') {
        return TetaActionType.cameraTakePhoto;
      } else if (json['aC'] == 'Switch camera') {
        return TetaActionType.cameraSwitchCamera;
      } else if (json['aC'] == 'Always flash') {
        return TetaActionType.cameraAlwaysFlash;
      } else if (json['aC'] == 'Auto flash') {
        return TetaActionType.cameraAutoFlash;
      } else if (json['aC'] == 'Torch flash') {
        return TetaActionType.cameraTorchFlash;
      } else if (json['aC'] == 'Toggle recording') {
        return TetaActionType.cameraStartRecoring;
      }
    } else if (json['aT'] == 'Custom Functions') {
      return TetaActionType.customFunction;
    } else if (json['aT'] == 'Theme') {
      if (json['aTh'] == 'Change theme') {
        return TetaActionType.themeChangeTheme;
      }
    } else if (json['aT'] == 'Translator') {
      if (json['aTrans'] == 'Translate') {
        return TetaActionType.translatorTranslate;
      }
    } else if (json['aT'] == 'Custom Http Request') {
      if (json['aCHr'] == 'Post') {
        return TetaActionType.customHttpPost;
      } else if (json['aCHr'] == 'Update') {
        return TetaActionType.customHttpUpdate;
      } else if (json['aCHr'] == 'Delete') {
        return TetaActionType.customHttpDelete;
      }
    } else if (json['aT'] == 'Google Maps') {
      if (json['actionGoogleMaps'] == 'Reload data') {
        return TetaActionType.googleMapsReloadData;
      } else if (json['actionGoogleMaps'] == 'Set camera position') {
        return TetaActionType.googleMapsSetCameraPosition;
      } else if (json['actionGoogleMaps'] == 'Update live location') {
        return TetaActionType.googleMapsUpdateDeviceLiveLocation;
      }
    } else if (json['aT'] == 'Api Calls') {
      if (json['aAC'] == 'Api calls') {
        return TetaActionType.apiCallsExecute;
      }
    } else if (json['aT'] == 'Airtable Database') {
      if (json['aD'] == 'Insert') {
        return TetaActionType.airtableInsert;
      } else if (json['aD'] == 'Delete') {
        return TetaActionType.airtableDelete;
      } else if (json['aD'] == 'Update') {
        return TetaActionType.airtableUpdate;
      }
    } else if (json['aT'] == 'State') {
      if (json['aS'] == 'Increment') {
        return TetaActionType.stateIncrement;
      } else if (json['aS'] == 'Decrement') {
        return TetaActionType.stateDecrement;
      } else if (json['aS'] == 'Change with') {
        return TetaActionType.stateChangeWith;
      } else if (json['aS'] == 'Change with Params') {
        return TetaActionType.stateChangeWithParam;
      } else if (json['aS'] == 'Email validator') {
        return TetaActionType.stateEmailValidator;
      } else if (json['aS'] == 'Phone validator') {
        return TetaActionType.statePhoneValidator;
      } else if (json['aS'] == 'Password validator') {
        return TetaActionType.statePasswordValidator;
      } else if (json['aS'] == 'Website validator') {
        return TetaActionType.stateWebsiteValidator;
      } else if (json['aS'] == 'Pick file') {
        return TetaActionType.statePickFile;
      } else if (json['aS'] == 'Unfocus') {
        return null; // TODO Implement
      }
    } else if (json['aT'] == 'Supabase auth') {
      if (json['sA'] == 'Sign in with credentials') {
        return TetaActionType.supabaseSignInWithCredentials;
      } else if (json['sA'] == 'Sign up') {
        return TetaActionType.supabaseSignUpWithCredentials;
      } else {
        return TetaActionType.supabaseSignInWithProvider;
      }
    } else if (json['aT'] == 'Supabase database') {
      if (json['sD'] == 'Insert') {
        return TetaActionType.supabaseInsert;
      } else if (json['sD'] == 'Update') {
        return TetaActionType.supabaseUpdate;
      } else if (json['sD'] == 'Delete') {
        return TetaActionType.supabaseDelete;
      }
    } else if (json['aT'] == 'Supabase functions') {
      if (json['supaFuncs'] == 'Invoke') {
        return TetaActionType.supabaseInsert;
      }
    } else if (json['aT'] == 'Supabase storage') {
      if (json['supaStor'] == 'Upload') {
        return TetaActionType.supabaseStorageUpload;
      } else if (json['supaStor'] == 'Remove') {
        return TetaActionType.supabaseStorageDelete;
      }
    } else if (json['aT'] == 'Audio player') {
      if (json['aAP'] == 'Play') {
        return TetaActionType.audioPlayerPlay;
      } else if (json['aAP'] == 'Play next track') {
        return TetaActionType.audioPlayerNextTrack;
      } else if (json['aAP'] == 'Play previous track') {
        return TetaActionType.audioPlayerPreviousTrack;
      } else if (json['aAP'] == 'Pause') {
        return TetaActionType.audioPlayerPause;
      } else if (json['aAP'] == 'Reload') {
        return TetaActionType.audioPlayerReload;
      } else if (json['aAP'] == 'Loop off') {
        return TetaActionType.audioPlayerLoopOff;
      } else if (json['aAP'] == 'Loop one') {
        return TetaActionType.audioPlayerLoopOne;
      } else if (json['aAP'] == 'Loop all') {
        return TetaActionType.audioPlayerLoopAll;
      }
    } else if (json['aT'] == 'Webview') {
      if (json['aW'] == 'Reload') {
        return TetaActionType.webViewReload;
      } else if (json['aW'] == 'Go back') {
        return TetaActionType.webViewGoBack;
      } else if (json['aW'] == 'Go forward') {
        return TetaActionType.webViewGoForward;
      } else if (json['aW'] == 'Navigate to') {
        return TetaActionType.webViewNavigateTo;
      }
    } else if (json['aT'] == 'Teta database') {
      if (json['aTDb'] == 'Insert') {
        return TetaActionType.tetaCmsDbInsert;
      } else if (json['aTDb'] == 'Update') {
        return TetaActionType.tetaCmsDbUpdate;
      } else if (json['aTDb'] == 'Delete') {
        return TetaActionType.tetaCmsDbDelete;
      }
    } else if (json['aT'] == 'Braintree') {
      if (json['aBrain'] == 'Pay') {
        return TetaActionType.braintreeBuy;
      }
    } else if (json['aT'] == 'Teta auth') {
      if (json['aTAu'] == 'Logout') {
        return TetaActionType.tetaCmsAuthLogout;
      } else {
        return TetaActionType.tetaCmsAuthLogin;
      }
    } else if (json['aT'] == 'Firebase analytics') {
      // TODO Implement
    } else if (json['aT'] == 'Firebase messages') {
      // TODO Implement
    } else if (json['aT'] == 'Teta store') {
      // TODO Implement
    }

    return null;
  }
}
