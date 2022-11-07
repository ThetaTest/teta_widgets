// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'dart:html';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseInsert {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
    final String? stateName,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final page = BlocProvider.of<PageCubit>(context).state;

    // Take status from states
    final status = takeStateFrom(page, 'status');

    changeState(status, context, 'Loading');
    final index =
        states.indexWhere((final element) => element.name == stateName);
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null && index != -1) {
      final bytes = await states[index].file?.readAsBytes();
      if (file == null) return;
      File
      final response = await client.storage
          .from(supabaseFrom?.get(
                params,
                states,
                dataset,
                true,
                loop,
                context,
              ) ??
              '',)
          .upload(
            pathFile?.get(
                  params,
                  states,
                  dataset,
                  true,
                  loop,
                  context,
                ) ??
                '', file,
          )
          .execute();
      if (response.error != null) changeState(status, context, 'Failed');
      changeState(status, context, 'Success');
    }
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
    final FTextTypeInput? supabaseFrom,
    final List<MapElement>? supabaseData,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state;
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
          } else if (e.value.type == FTextTypeEnum.state) {
            map[e.key] = e.value.toCode(
              0,
              resultType: ResultTypeEnum.string,
            );
          } else if (e.value.type == FTextTypeEnum.param) {
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
              .from(${supabaseFrom?.toCode(
                0,
                resultType: ResultTypeEnum.string,
              ) ?? ''})
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