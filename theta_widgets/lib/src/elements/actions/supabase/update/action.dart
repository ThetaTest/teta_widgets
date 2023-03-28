import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TASupabaseUpdate extends TetaAction {
  TASupabaseUpdate({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TASupabaseUpdate.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TASupabaseUpdateParams.fromJson(
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
  TASupabaseUpdateParams get params => super.params as TASupabaseUpdateParams;

  @override
  TetaActionType get type => TetaActionType.supabaseUpdate;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.supabaseEq == null) return;
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;

    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final map = <String, dynamic>{};
      for (final e in params.supabaseData ?? <MapElement>[]) {
        if (e.key.toLowerCase() != 'id') {
          map[e.key] = e.value.get(
            pageState.params,
            pageState.states,
            pageState.datasets,
            true,
            state.loop,
            context,
          );
        } else {
          map[e.key] = int.tryParse(
            e.value.get(
              pageState.params,
              pageState.states,
              pageState.datasets,
              true,
              state.loop,
              context,
            ),
          );
        }
      }
      dynamic eqValue;
      if (params.supabaseEq!.key.toLowerCase() != 'id') {
        eqValue = params.supabaseEq!.value.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          state.loop,
          context,
        );
      } else {
        eqValue = int.tryParse(
          params.supabaseEq!.value.get(
            pageState.params,
            pageState.states,
            pageState.datasets,
            true,
            state.loop,
            context,
          ),
        );
      }
      await client
          .from(
            params.supabaseFrom?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  state.loop,
                  context,
                ) ??
                '',
          )
          .update(map)
          .eq(params.supabaseEq!.key, eqValue)
          .execute();
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
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final map = <String, dynamic>{};
      for (final e in params.supabaseData ?? <MapElement>[]) {
        if (e.key.toLowerCase() != 'id') {
          map[e.key] = e.value.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
        } else {
          map[e.key] = int.tryParse(
            e.value.toCode(
              0,
              resultType: ResultTypeEnum.int,
            ),
          );
        }
      }
      dynamic eqValue;
      if (params.supabaseEq?.key.toLowerCase() != 'id') {
        eqValue = params.supabaseEq?.value.toCode(
          0,
          resultType: ResultTypeEnum.string,
        );
      } else {
        eqValue = int.tryParse(
          params.supabaseEq!.value.toCode(
            0,
            resultType: ResultTypeEnum.int,
          ),
        );
      }
      final mapString = StringBuffer()..write('{');
      for (final key in map.keys) {
        mapString.write("'''$key''': ${map[key]},");
      }
      mapString.write('}');
      return '''
        final response = await Supabase.instance.client
              .from(${params.supabaseFrom?.toCode(
                0,
                resultType: ResultTypeEnum.string,
              ) ?? ''})
              .update($mapString)
              .eq('${params.supabaseEq?.key}', $eqValue)
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
