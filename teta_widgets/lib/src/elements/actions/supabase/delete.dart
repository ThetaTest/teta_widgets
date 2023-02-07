// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseDelete {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final MapElement supabaseEq,
    final int? loop,
  ) async {
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;

    // Take status from states
    final status = takeStateFrom(pageState, 'status');
    updateStateValue(
      context,
      'status',
      'Loading',
    );
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      dynamic eqValue;
      if (supabaseEq.key.toLowerCase() != 'id') {
        eqValue = supabaseEq.value.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          loop,
          context,
        );
      } else {
        eqValue = int.tryParse(
          supabaseEq.value.get(
            pageState.params,
            pageState.states,
            pageState.datasets,
            true,
            loop,
            context,
          ),
        );
      }
      final response = await client
          .from(
            supabaseFrom?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  loop,
                  context,
                ) ??
                '',
          )
          .delete()
          .eq(supabaseEq.key, eqValue)
          .execute();
      if (response.error != null) {
        updateStateValue(
          context,
          'status',
          'Failed',
        );
      } else {
        updateStateValue(
          context,
          'status',
          'Success',
        );
      }
    }
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
    final FTextTypeInput? supabaseFrom,
    final MapElement? supabaseEq,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      dynamic eqValue;
      if (supabaseEq?.key.toLowerCase() != 'id') {
        eqValue = supabaseEq?.value.toCode(
          0,
          resultType: ResultTypeEnum.string,
        );
      } else {
        eqValue = int.tryParse(
          supabaseEq!.value.toCode(
            0,
            resultType: ResultTypeEnum.string,
          ),
        );
      }
      return '''
        final response = await Supabase.instance.client
              .from(${supabaseFrom?.toCode(
                0,
                resultType: ResultTypeEnum.string,
              ) ?? ''})
              .delete()
              .eq('${supabaseEq?.key}', $eqValue)
              .execute();
        if (response.error != null) {
          ${status != null ? "setState(() { status = 'Failed'; });" : ''}
        } else {
          ${status != null ? "setState(() { status = 'Success'; });" : ''}
        }
      ''';
    } else {
      return '';
    }
  }
}
