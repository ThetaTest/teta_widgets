import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/index.dart';
import '../../../snippets/take_state_from.dart';
import '../../../snippets/update_state_value.dart';
import 'params.dart';

class TATetaCMSOnAll extends TetaAction {
  TATetaCMSOnAll({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TATetaCMSOnAll.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TATetaCMSOnAllParams.fromJson(
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
  TATetaCMSOnAllParams get params => super.params as TATetaCMSOnAllParams;

  @override
  TetaActionType get type => TetaActionType.tetaCmsDbOnAll;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.stateName == null) return;
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;
    final stateTaken = takeStateFrom(pageState, params.stateName!);
    if (params.collection == null) return;
    final collectionId = params.collection!.get(
      pageState.params,
      pageState.states,
      pageState.datasets,
      true,
      state.loop,
      context,
    );
    await TetaCMS.I.db.fromId(collectionId).on(
      callback: (final event) {
        if (stateTaken != null && stateTaken.type == VariableType.json) {
          updateStateValue(
            context,
            stateTaken.name,
            event.action,
          );
        }
      },
    );
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return 'TATetaCMSOnAll.getActionCode() not implemented';
    // final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    // final status = takeStateFrom(page, 'status');
    // final client = BlocProvider.of<SupabaseCubit>(context).state;
    // if (client != null) {
    //   final map = <String, dynamic>{};
    //   for (final e in supabaseData ?? <MapElement>[]) {
    //     if (e.key.toLowerCase() != 'id') {
    //       if (e.value.type == FTextTypeEnum.text) {
    //         map[e.key] = e.value.toCode(
    //           0,
    //           resultType: ResultTypeEnum.string,
    //         );
    //       } else {
    //         map[e.key] = e.value.toCode(
    //           0,
    //           resultType: ResultTypeEnum.string,
    //         );
    //       }
    //     } else {
    //       map[e.key] = int.tryParse(
    //         e.value.toCode(
    //           0,
    //           resultType: ResultTypeEnum.int,
    //         ),
    //       );
    //     }
    //   }
    //   final mapString = StringBuffer()..write('{');
    //   for (final key in map.keys) {
    //     mapString.write("'''$key''': ${map[key]},");
    //   }
    //   mapString.write('}');
    //   return '''
    //     final response = await Supabase.instance.client
    //           .from(${supabaseFrom?.toCode(
    //             0,
    //             resultType: ResultTypeEnum.string,
    //           ) ?? ''})
    //           .insert($mapString)
    //           .execute();
    //     if (response.error != null) {
    //       ${status != null ? "setState(() { status = 'Failed'; });" : ''}
    //     } else {
    //       ${status != null ? "setState(() { status = 'Success'; });" : ''}
    //     }
    //   ''';
    // } else {
    //   return '';
    // }
  }
}
