

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

import '../../../../teta_widgets.dart';
import '../../../core/teta_widget/index.dart';
import '../navigation/open_page.dart';
import '../snippets/change_state.dart';

class FASupabaseSignUpWithPhone {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String value,
    final CNode scaffold,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) async {
  final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;

  ///Phone number from state
  final phone = takeStateFrom(page, 'phone');
  ///Phone number from state
  final password = takeStateFrom(page, 'password');
  // Take status from states
    final status = takeStateFrom(page, 'status');

  if (phone != null && password != null) {
   changeState(status, context, 'Loading'); 
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final response = await client.auth.signUpWithPhone('${phone.get}', '${password.get}');
      if (response.error == null) {
          changeState(status, context, '${response.error?.message}');
        }else{
           changeState(status, context, 'Success');
          final box = await Hive.openBox<dynamic>('social_login');
          await box.put('key', {'phone': '${phone.get}'});
          await FActionNavigationOpenPage.action(
            context,
            state,
            nameOfPage,
            paramsToSend,
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
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final status = takeStateFrom(page, 'status');
    final phone = takeStateFrom(page, 'phone');
    final password = takeStateFrom(page, 'password');
    if (phone == null || password == null) return '';
    return '''
    if (phone != null && otp != null) {
      ${status != null ? "setState(() { status = 'Loading'; });" : ''}
      final response = await Supabase.instance.client.auth.signUp(phone, password);
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
