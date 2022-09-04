// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FASupabaseSignUp {
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
    final page = BlocProvider.of<PageCubit>(context).state;

    // Take email from states
    final email = takeStateFrom(page, 'email');

    // Take password from states
    final password = takeStateFrom(page, 'password');

    // Take status from states
    final status = takeStateFrom(page, 'status');

    if (email != null && password != null) {
      changeState(status, context, 'Loading');
      final client = BlocProvider.of<SupabaseCubit>(context).state;
      if (client != null) {
        final response =
            await client.auth.signUp('${email.get}', '${password.get}');
        if (response.error != null) {
          changeState(status, context, '${response.error?.message}');
        } else {
          changeState(status, context, 'Success');
          final box = await Hive.openBox<dynamic>('social_login');
          await box.put('key', {'email': '${email.get}'});
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
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state;
    final status = takeStateFrom(page, 'status');
    final email = takeStateFrom(page, 'email');
    final password = takeStateFrom(page, 'password');
    if (email == null || password == null) return '';
    return '''
    if (email != null && password != null) {
      ${status != null ? "setState(() { status = 'Loading'; });" : ''}
      final response = await Supabase.instance.client.auth.signUp(email, password);
      if (response.error != null) {
        ${status != null ? "setState(() { status = 'Failed'; });" : ''}
      } else {
        ${status != null ? "setState(() { status = 'Success'; });" : ''}
        ${FActionNavigationOpenPage.toCode(context, nameOfPage, paramsToSend)}
      }
    }
    ''';
  }
}
