import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/index.dart';
import '../../../navigation/open_page/action.dart';
import '../../../navigation/open_page/params.dart';
import 'params.dart';

class TATetaCMSLogin extends TetaAction {
  TATetaCMSLogin({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TATetaCMSLogin.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TATetaCMSLoginParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TATetaCMSLoginParams get params => super.params as TATetaCMSLoginParams;

  @override
  TetaActionType get type => TetaActionType.tetaCmsAuthLogin;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    try {
      await TetaCMS.instance.auth.signIn(
        provider: params.provider,
        fromEditor: true,
        onSuccess: (final isFirstTime) async {
          await TANavigationOpenPage(
            params: TANavigationOpenPageParams(
              nameOfPage: params.nameOfPage,
              paramsToSend: params.paramsToSend,
            ),
          ).execute(context, state);
        },
      );
    } catch (e) {
      Logger.printError('TATetaCMSLogin $e');
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final configState = BlocProvider.of<ConfigCubit>(context).state;
    final config = (configState as ConfigStateLoaded).config;
    final openPageActionToCode = TANavigationOpenPage(
      params: TANavigationOpenPageParams(
        nameOfPage: params.nameOfPage,
        paramsToSend: params.paramsToSend,
      ),
    ).toCode(context, pageId, loop);

    final providerMap = {
      TetaProvider.google: 'TetaProvider.google',
      TetaProvider.twitter: 'TetaProvider.twitter',
      TetaProvider.apple: 'TetaProvider.apple',
      TetaProvider.facebook: 'TetaProvider.facebook',
      TetaProvider.twitch: 'TetaProvider.twitch',
      TetaProvider.linkedin: 'TetaProvider.linkedin',
      TetaProvider.discord: 'TetaProvider.discord',
      TetaProvider.gitlab: 'TetaProvider.gitlab',
      TetaProvider.bitbucket: 'TetaProvider.bitbucket',
      TetaProvider.github: 'TetaProvider.github',
    };

    final providerStr = providerMap[params.provider] ?? 'TetaProvider.google';
    return '''
      await TetaCMS.instance.auth.signIn(
        provider: $providerStr,
        onSuccess: (final isFirstTime) async {
          final user = await TetaCMS.instance.auth.user.get;
          ${config.revenuecat.isEnabled ? r"LogInResult result = await Purchases.logIn('${user.uid}');" : ''}
          ${config.qonversion.isEnabled ? r"Qonversion.setProperty(QUserProperty.customUserId, '${user.uid}');" : ''}
          $openPageActionToCode
        }
      );
      ''';
  }
}
