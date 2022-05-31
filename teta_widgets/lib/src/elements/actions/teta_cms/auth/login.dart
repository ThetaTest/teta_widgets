// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:uni_links/uni_links.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
// Project imports:

class FATetaCMSLogin {
  static Future action(
    final CNode node,
    final String? nameOfPage,
    final BuildContext context,
    final Map<String, dynamic>? paramsToSend,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
    final TetaProvider provider,
  ) async {
    final prjId =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
            .prj
            .id;
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final status = takeStateFrom(page, 'status');

    final resp = await TetaCMS.instance.auth.signInWithBrowser(
      context,
      prjId,
      provider: provider,
    );
    if (!UniversalPlatform.isWeb) {
      uriLinkStream.listen(
        (final Uri? uri) async {
          debugPrint('uri: ${uri.toString()}');
          if (uri != null) {
            if (uri.queryParameters['access_token'] != null &&
                uri.queryParameters['access_token'] is String) {
              await closeInAppWebView();
              await TetaCMS.instance.auth.insertUser(
                // ignore: cast_nullable_to_non_nullable
                uri.queryParameters['access_token'] as String,
              );
              if (!resp) {
                changeState(status, context, 'Failed');
              } else {
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
          }
        },
        onError: (final Object err) {
          throw Exception('got err: $err');
        },
      );
    } else {
      if (!resp) {
        changeState(status, context, 'Failed');
      } else {
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
  }

  static String toCode(
    final BuildContext context,
    final TetaProvider provider,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    final providerStr = provider == TetaProvider.google
        ? 'TetaProvider.google'
        : 'TetaProvider.github';
    return '''
      final resp = await TetaCMS.instance.auth.signInWithBrowser(
        context,
        provider: $providerStr,
      );
      if (!UniversalPlatform.isWeb) {
        uriLinkStream.listen(
          (final Uri? uri) async {
            if (uri != null) {
              if (uri.queryParameters['access_token'] != null &&
                uri.queryParameters['access_token'] is String) {
                await closeInAppWebView();
                await TetaCMS.instance.auth.insertUser(
                  // ignore: cast_nullable_to_non_nullable
                  uri.queryParameters['access_token'] as String,
                );
                ${FActionNavigationOpenPage.toCode(context, nameOfPage, paramsToSend)}
              }
            }
          },
          onError: (final Object err) {
            throw Exception('got err: \$err');
          },
        );
      }
      ''';
  }
}
