// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/cubits/supabase.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FASupabaseSignUp {
  static Future action(
    BuildContext context,
    String value,
    CNode scaffold,
    CNode node,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop,
  ) async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;

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
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
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
