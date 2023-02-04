

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

import '../../../../teta_widgets.dart';
import '../../../core/teta_widget/index.dart';
import '../navigation/open_page.dart';
import '../snippets/change_state.dart';

class FASupabaseSignOut{
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String value,
    final CNode scaffold,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) async {
  final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;

  // Take status from states
    final status = takeStateFrom(page, 'status');
   changeState(status, context, 'Loading'); 
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final response = await client.auth.signOut();
      if (response.error == null) {
          changeState(status, context, '${response.error?.message}');
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
    
    return '''
    
      ${status != null ? "setState(() { status = 'Loading'; });" : ''}
      final response = await Supabase.instance.client.auth.signOut();
      if (response.error != null) {
        ${status != null ? "setState(() { status = 'Failed'; });" : ''}
      } else {
        ${status != null ? "setState(() { status = 'Success'; });" : ''}
        ${FActionNavigationOpenPage.toCode(context, nameOfPage, paramsToSend)}
      }
    
    ''';
  }
  
  }
