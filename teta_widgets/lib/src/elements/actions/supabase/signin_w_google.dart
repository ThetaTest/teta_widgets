// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/cubits/supabase.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/src/services/user_social_login/enums/login_provider.dart';
import 'package:teta_core/src/services/user_social_login/services/social_login_service/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FASupabaseSignInWithGoogle {
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
    final int? loop,
  ) async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;

    // Take status from states
    final status = takeStateFrom(page, 'status');

    changeState(status, context, 'Loading');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final response = await UserSocialLoginService.instance
          .executeLogin(client.supabaseUrl, LoginProvider.google);

      if (response.jwt.isEmpty) changeState(status, context, 'Failed');
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
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    return '''
    await Supabase.instance.client.auth.signInWithProvider(Provider.google);
    ${FActionNavigationOpenPage.toCode(context, nameOfPage, paramsToSend)}
    ''';
  }
}
