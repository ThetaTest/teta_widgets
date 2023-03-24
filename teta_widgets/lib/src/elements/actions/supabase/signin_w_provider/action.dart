import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teta_core/src/services/user_social_login/services/social_login_service/index.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:uni_links/uni_links.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../navigation/open_page/action.dart';
import '../../navigation/open_page/params.dart';
import 'params.dart';

class TASupabaseSignInWithProvider extends TetaAction {
  TASupabaseSignInWithProvider({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TASupabaseSignInWithProvider.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TASupabaseSignInWithProviderParams.fromJson(
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
  TASupabaseSignInWithProviderParams get params =>
      super.params as TASupabaseSignInWithProviderParams;

  @override
  TetaActionType get type => TetaActionType.supabaseSignInWithProvider;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;

    // Take status from states
    final status = takeStateFrom(page, 'status');

    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      await UserSocialLoginService.instance
          .executeLogin(client.supabaseUrl, params.provider);

      if (!UniversalPlatform.isWeb) {
        uriLinkStream.listen(
          (final Uri? uri) {
            if (uri != null) {
              final uriParameters =
                  SupabaseAuth.instance.parseUriParameters(Uri.base);
              if (uriParameters.containsKey('access_token') &&
                  uriParameters.containsKey('refresh_token') &&
                  uriParameters.containsKey('expires_in')) {
                closeInAppWebView();
              }
            }
          },
          onError: (final Object err) {
            throw Exception('got err: $err');
          },
        );
      }
      await TANavigationOpenPage(
        params: TANavigationOpenPageParams(
          nameOfPage: params.nameOfPage,
          paramsToSend: params.paramsToSend,
        ),
      ).execute(context, state);
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''
    await Supabase.instance.client.auth.signInWithProvider(${params.provider});
    if (!UniversalPlatform.isWeb) {
      uriLinkStream.listen(
        (final Uri? uri) async {
          if (uri != null) {
            if (uri.queryParameters['access_token'] != null &&
                uri.queryParameters['access_token'] is String) {
              await recoverSessionFromUrl(uri);
              await closeInAppWebView();
              unawaited(
                TetaCMS.instance.analytics.insertEvent(
                  TetaAnalyticsType.tetaAuthSignIn,
                  'Supabase Auth: signIn request',
                  <String, dynamic>{
                    'device': 'mobile',
                    'provider': 'supabase',
                  },
                  isUserIdPreferableIfExists: false,
                ),
              );
            }
          }
        },
        onError: (final Object err) {
          throw Exception('got err: \$err');
        },
      );
    }
    ${TANavigationOpenPage(
      params: TANavigationOpenPageParams(
        nameOfPage: params.nameOfPage,
        paramsToSend: params.paramsToSend,
      ),
    ).toCode(context, pageId, loop)}
    ''';
  }
}
