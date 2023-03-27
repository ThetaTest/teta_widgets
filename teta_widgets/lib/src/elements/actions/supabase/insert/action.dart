import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TASupabaseInsert extends TetaAction {
  TASupabaseInsert({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TASupabaseInsert.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TASupabaseInsertParams.fromJson(
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
  TASupabaseInsertParams get params => super.params as TASupabaseInsertParams;

  @override
  TetaActionType get type => TetaActionType.supabaseInsert;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
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
          .insert(
            map,
            returning: ReturningOption.minimal,
          )
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
              .from(${params.supabaseFrom?.toCode(
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
