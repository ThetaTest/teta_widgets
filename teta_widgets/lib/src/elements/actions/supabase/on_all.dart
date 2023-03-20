// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FASupabaseOnAll {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final String? stateName,
    final int? loop,
  ) async {
    if (stateName == null) return;
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    final state = takeStateFrom(pageState, stateName);
    if (client != null) {
      client
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
          .on(SupabaseEventTypes.all, (final payload) {
        if (state != null && state.type == VariableType.json) {
          updateStateValue(
            context,
            state.name,
            payload.newRecord ?? payload.oldRecord,
          );
        }
      }).subscribe();
    }
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
    final FTextTypeInput? supabaseFrom,
    final List<MapElement>? supabaseData,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final map = <String, dynamic>{};
      for (final e in supabaseData ?? <MapElement>[]) {
        if (e.key.toLowerCase() != 'id') {
          if (e.value.type == FTextTypeEnum.text) {
            map[e.key] = e.value.toCode(
              0,
              resultType: ResultTypeEnum.string,
            );
          } else {
            map[e.key] = e.value.toCode(
              0,
              resultType: ResultTypeEnum.string,
            );
          }
        } else {
          map[e.key] = int.tryParse(
            e.value.toCode(
              0,
              resultType: ResultTypeEnum.int,
            ),
          );
        }
      }
      final mapString = StringBuffer()..write('{');
      for (final key in map.keys) {
        mapString.write("'$key': ${map[key]},");
      }
      mapString.write('}');
      return '''
        final response = await Supabase.instance.client
              .from('${supabaseFrom?.toCode(
                0,
                resultType: ResultTypeEnum.string,
              ) ?? ''}')
              .insert($mapString, returning: ReturningOption.minimal,)
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
