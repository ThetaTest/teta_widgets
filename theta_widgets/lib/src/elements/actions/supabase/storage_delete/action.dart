import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TASupabaseStorageDelete extends TetaAction {
  TASupabaseStorageDelete({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TASupabaseStorageDelete.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TASupabaseStorageDeleteParams.fromJson(
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
  TASupabaseStorageDeleteParams get params =>
      super.params as TASupabaseStorageDeleteParams;

  @override
  TetaActionType get type => TetaActionType.supabaseStorageDelete;

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
      await client.storage
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
          .remove(
        [
          params.pathFile?.get(
                pageState.params,
                pageState.states,
                pageState.datasets,
                true,
                state.loop,
                context,
              ) ??
              '',
        ],
      );
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
    final from = params.supabaseFrom?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final path = params.pathFile?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    return '''
      await Supabase.instance.client.storage.from($from).remove([$path]);
      if (res.error != null) {
        debugPrint(
          'Error retriving the public url, error: \${res.error?.message}',
        );
      }
    ''';
  }
}
