import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../navigation/open_page/action.dart';
import '../../navigation/open_page/params.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TASupabaseSignUp extends TetaAction {
  TASupabaseSignUp({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TASupabaseSignUp.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TASupabaseSignUpParams.fromJson(
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
  TASupabaseSignUpParams get params => super.params as TASupabaseSignUpParams;

  @override
  TetaActionType get type => TetaActionType.supabaseSignUpWithCredentials;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;

    // Take email from states
    final email = takeStateFrom(page, 'email');

    // Take password from states
    final password = takeStateFrom(page, 'password');

    if (email != null && password != null) {
      final client = BlocProvider.of<SupabaseCubit>(context).state;
      if (client != null) {
        final response =
            await client.auth.signUp('${email.get}', '${password.get}');
        if (response.error == null) {
          final box = await Hive.openBox<dynamic>('social_login');
          await box.put('key', {'email': '${email.get}'});
          await TANavigationOpenPage(
            params: TANavigationOpenPageParams(
              nameOfPage: params.nameOfPage,
              paramsToSend: params.paramsToSend,
            ),
          ).execute(context, state);
        }
      }
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final status = takeStateFrom(page, 'status');
    final email = takeStateFrom(page, 'email');
    final password = takeStateFrom(page, 'password');
    if (email == null || password == null) return '';
    final openPageAction = TANavigationOpenPage(
      params: TANavigationOpenPageParams(
        nameOfPage: params.nameOfPage,
        paramsToSend: params.paramsToSend,
      ),
    );
    return '''
    if (email != null && password != null) {
      ${status != null ? "setState(() { status = 'Loading'; });" : ''}
      final response = await Supabase.instance.client.auth.signUp(email, password);
      if (response.error != null) {
        ${status != null ? "setState(() { status = 'Failed'; });" : ''}
      } else {
        ${status != null ? "setState(() { status = 'Success'; });" : ''}
        ${openPageAction.toCode(context, pageId, loop)}
      }
    }
    ''';
  }
}
