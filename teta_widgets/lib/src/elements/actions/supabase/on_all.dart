// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/cubits/supabase.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/map_element.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseOnAll {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final String? stateName,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    final state = takeStateFrom(page, stateName ?? '');
    if (client != null) {
      client
          .from(supabaseFrom?.get(params, states, dataset, true, loop) ?? '')
          .on(SupabaseEventTypes.all, (final payload) {
        if (state != null && state.type == VariableType.json) {
          state.value = payload.newRecord ?? payload.oldRecord;
          update(context);
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
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final map = <String, dynamic>{};
      for (final e in supabaseData ?? <MapElement>[]) {
        if (e.key.toLowerCase() != 'id') {
          if (e.value.type == FTextTypeEnum.text) {
            map[e.key] = '"${e.value.toCode(0)}"';
          } else {
            map[e.key] = e.value.toCode(0);
          }
        } else {
          map[e.key] = int.tryParse(e.value.toCode(0));
        }
      }
      final mapString = StringBuffer()..write('{');
      for (final key in map.keys) {
        mapString.write("'''$key''': ${map[key]},");
      }
      mapString.write('}');
      return '''
        final response = await Supabase.instance.client
              .from(${supabaseFrom?.toCode(0) ?? ''})
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
