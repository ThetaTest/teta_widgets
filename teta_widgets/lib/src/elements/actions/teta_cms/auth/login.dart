// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/src/services/track_service.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class FATetaCMSLogin {
  static Future action(
    final TetaWidgetState state,
    final String? nameOfPage,
    final BuildContext context,
    final Map<String, dynamic>? paramsToSend,
    final TetaProvider provider,
  ) async {
    final prj = (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;

    // final page = BlocProvider.of<PageCubit>(context).state;
    // final status = takeStateFrom(page, 'status');

    /*
    await showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (final context) => PrivacyTermsDialog(
        config: prj.config!,
      ),
    );
    */

    TrackService.instance.track(
      eventName: 'Teta Auth: login in Teta',
      eventProperties: <String, String>{
        'provider': EnumToString.convertToString(provider),
      },
      prjId: prj.id,
    );

    await TetaCMS.instance.auth.signIn(
      provider: provider,
      fromEditor: true,
      onSuccess: (final isFirstTime) async {
        await FActionNavigationOpenPage.action(
          context,
          state,
          nameOfPage,
          paramsToSend,
        );
      },
    );
  }

  static String toCode(
    final BuildContext context,
    final TetaProvider provider,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    final prj = (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    final isRevenueCatEnabled = prj.config?.isRevenueCatEnabled ?? false;
    final providerStr = provider == TetaProvider.google
        ? 'TetaProvider.google'
        : provider == TetaProvider.twitter
            ? 'TetaProvider.twitter'
            : provider == TetaProvider.apple
                ? 'TetaProvider.apple'
                : 'TetaProvider.github';
    return '''
      await TetaCMS.instance.auth.signIn(
        provider: $providerStr,
        onSuccess: (final isFirstTime) async {
          final user = await TetaCMS.instance.auth.user.get;
          ${isRevenueCatEnabled ? r"LogInResult result = await Purchases.logIn('${user.uid}');" : ''}
          ${prj.config?.isQonversionReady ?? false ? r"Qonversion.setProperty(QUserProperty.customUserId, '${user.uid}');" : ''}
          ${FActionNavigationOpenPage.toCode(context, nameOfPage, paramsToSend)}
        }
      );
      ''';
  }
}
