// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teta_core/src/services/user_social_login/services/social_login_service/index.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:uni_links/uni_links.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class FASupabaseSignInWithProvider {
  static Future action(
    final BuildContext context,
    final String value,
    final CNode scaffold,
    final CNode node,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final Provider provider,
    final int? loop,
  ) async {
    final page = BlocProvider.of<PageCubit>(context).state;

    // Take status from states
    final status = takeStateFrom(page, 'status');

    changeState(status, context, 'Loading');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final response = await UserSocialLoginService.instance
          .executeLogin(client.supabaseUrl, provider);

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
            throw 'got err: $err';
          },
        );
      }

      if (response != null && response.jwt.isEmpty) {
        changeState(status, context, 'Failed');
      }
      changeState(status, context, 'Success');
      await FActionNavigationOpenPage.action(
        node,
        context,
        nameOfPage,
        paramsToSend,
        params,
        states,
        dataset,
        loop,
      );
    }
  }

  static String toCode(
    final BuildContext context,
    final Provider provider,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    return '''
    await Supabase.instance.client.auth.signInWithProvider($provider);
    if (!UniversalPlatform.isWeb) {
      uriLinkStream.listen(
        (final Uri? uri) async {
          if (uri != null) {
            if (uri.queryParameters['access_token'] != null &&
                uri.queryParameters['access_token'] is String) {
              await recoverSessionFromUrl(uri!);
              await closeInAppWebView();
              unawaited(
                TetaCMS.instance.analytics.insertEvent(
                  TetaAnalyticsType.tetaAuthSignIn,
                  'Supabase Auth: signIn request',
                  <String, dynamic>{
                    'device': 'mobile',
                    'provider': EnumToString.convertToString(provider),
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
    ${FActionNavigationOpenPage.toCode(context, nameOfPage, paramsToSend)}
    ''';
  }
}
