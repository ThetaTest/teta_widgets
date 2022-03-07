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
import 'package:teta_core/src/models/supabase_map_element.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseOnInsert {
  static Future action(
    BuildContext context,
    FTextTypeInput? supabaseFrom,
    String? stateName,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop,
  ) async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    final state = takeStateFrom(page, stateName ?? '');
    if (client != null) {
      client
          .from(supabaseFrom?.get(params, states, dataset, true, loop) ?? '')
          .on(SupabaseEventTypes.insert, (payload) {
        if (state != null && state.type == VariableType.json) {
          state.value = payload.newRecord ?? payload.oldRecord;
          update(context);
        }
      }).subscribe();
    }
  }

  static String toCode(
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
    FTextTypeInput? supabaseFrom,
    List<SupabaseMapElement>? supabaseData,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final map = <String, dynamic>{};
      for (final e in supabaseData ?? <SupabaseMapElement>[]) {
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
              .insert($mapString)
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
