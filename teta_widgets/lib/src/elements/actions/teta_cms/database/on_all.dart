// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FATetaCMSOnAll {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? collection,
    final String? stateName,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final page = BlocProvider.of<PageCubit>(context).state;
    final state = takeStateFrom(page, stateName ?? '');
    if (collection != null) {
      final collectionId = collection.get(
        params,
        states,
        dataset,
        true,
        loop,
        context,
      );
      await TetaCMS.instance.realtime.on(
        collectionId: collectionId,
        callback: (final event) {
          if (state != null && state.type == VariableType.json) {
            state.value = event.action;
            update(context);
          }
        },
      );
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
