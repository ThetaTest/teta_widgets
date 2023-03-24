import 'package:teta_models/teta_models.dart';

import '../../../elements/nodes/enum.dart';
import '../index.dart';
import 'types.dart';

class TetaActionGroup {
  TetaActionGroup(this.name, this.actions);

  final String name;
  final List<TetaActionType> actions;
}

abstract class TetaActionGroups {
  static final _groups = <TetaActionGroup>[
    TetaActionGroup('Alert', TetaActionType.alertActions),
    TetaActionGroup('State', TetaActionType.stateActions),
    TetaActionGroup('Navigation', TetaActionType.navigationActions),
    TetaActionGroup('Teta Auth', TetaActionType.tetaAuthActions),
    TetaActionGroup('Teta CMS', TetaActionType.tetaDbActions),
    TetaActionGroup('Custom HTTP Request', TetaActionType.customHttpActions),
    TetaActionGroup('Api Calls', TetaActionType.apiCallsActions),
    TetaActionGroup('Translator', TetaActionType.translatorActions),
    TetaActionGroup('Theme', TetaActionType.themeActions),
    TetaActionGroup('Mixpanel', TetaActionType.mixpanelActions),
    TetaActionGroup('Supabase Auth', TetaActionType.supabaseAuthActions),
    TetaActionGroup('Supabase DB', TetaActionType.supabaseDBActions),
    TetaActionGroup(
      'Supabase Functions',
      TetaActionType.supabaseFunctionsActions,
    ),
    TetaActionGroup(
      'Supabase Storage',
      TetaActionType.supabaseStorageActions,
    ),
    TetaActionGroup('Airtable Database', TetaActionType.airtableActions),
    TetaActionGroup('RevenueCat', TetaActionType.revenueCatActions),
    TetaActionGroup('Qonversion', TetaActionType.qonversionActions),
    TetaActionGroup('Braintree', TetaActionType.braintreeActions),
    TetaActionGroup('WebView', TetaActionType.webViewActions),
    TetaActionGroup('Audio Player', TetaActionType.audioPlayerActions),
    TetaActionGroup('Google Maps', TetaActionType.googleMapsActions),
  ];

  static TetaActionGroup getGroup(final String name) =>
      _groups.firstWhere((final e) => e.name == name);

  static List<TetaActionGroup> getActionGroups(
    final PageObject page,
    final ProjectConfigModel config,
  ) {
    final groups = List<TetaActionGroup>.from(_groups);

    // Remove actions that are not available
    if (config.mixpanel is! MixpanelConfigModelInitialized) {
      groups.removeWhere((final e) => e.name == 'Mixpanel');
    }
    if (config.revenuecat is! RevenueCatConfigModelInitialized) {
      groups.removeWhere((final e) => e.name == 'RevenueCat');
    }
    if (config.supabase is! SupabaseConfigModelInitialized) {
      groups
        ..removeWhere((final e) => e.name == 'Supabase Auth')
        ..removeWhere((final e) => e.name == 'Supabase Functions')
        ..removeWhere((final e) => e.name == 'Supabase Storage')
        ..removeWhere((final e) => e.name == 'Supabase DB');
    }
    if (config.airtable is! AirtableConfigModelInitialized) {
      groups.removeWhere((final e) => e.name == 'Airtable Database');
    }
    if (config.qonversion is! QonversionConfigModelInitialized) {
      groups.removeWhere((final e) => e.name == 'Qonversion');
    }
    if (config.braintree is! BraintreeConfigModelInitialized) {
      groups.removeWhere((final e) => e.name == 'Braintree');
    }
    if ((page.flatList).indexWhere(
          (final e) => e.intrinsicState.type == NType.webview,
        ) ==
        -1) {
      groups.removeWhere((final e) => e.name == 'WebView');
    }
    if ((page.flatList).indexWhere(
          (final e) => e.intrinsicState.type == NType.audioPlayer,
        ) ==
        -1) {
      groups.removeWhere((final e) => e.name == 'Audio Player');
    }
    if ((page.flatList).indexWhere(
          (final e) => e.intrinsicState.type == NType.googleMaps,
        ) ==
        -1) {
      groups.removeWhere((final e) => e.name == 'Google Maps');
    }

    return groups;
  }
}
