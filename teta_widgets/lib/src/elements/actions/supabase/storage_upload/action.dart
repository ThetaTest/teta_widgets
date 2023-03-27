import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TASupabaseStorageUpload extends TetaAction {
  TASupabaseStorageUpload({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TASupabaseStorageUpload.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TASupabaseStorageUploadParams.fromJson(
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
  TASupabaseStorageUploadParams get params =>
      super.params as TASupabaseStorageUploadParams;

  @override
  TetaActionType get type => TetaActionType.supabaseStorageUpload;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;

    final index = pageState.states
        .indexWhere((final element) => element.name == params.stateName);
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null && index != -1) {
      final bytes = await pageState.states[index].file?.readAsBytes();
      if (bytes == null || bytes.isEmpty) return;
      final response = await client.storage
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
          .uploadBinary(
            params.pathFile?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  state.loop,
                  context,
                ) ??
                '',
            bytes,
          );
      final index2 = pageState.states
          .indexWhere((final element) => element.name == params.stateName2);
      final res = client.storage
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
          .getPublicUrl(
            params.pathFile?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  state.loop,
                  context,
                ) ??
                '',
          );
      if (res.error != null) {
        Logger.printError(
          'Error retriving the public url from just uploaded file, error: ${res.error?.message}',
        );
      }
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    if (params.stateName == null || params.stateName2 == null) return '';

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
    final varName = ReCase(params.stateName!).camelCase;
    final varName2 = ReCase(params.stateName2!).camelCase;
    return '''
      final bytes = await $varName.readAsBytes();
      await Supabase.instance.client.storage.from($from).uploadBinary($path,bytes);
      final res = Supabase.instance.client.storage.from($from).getPublicUrl($path);
      if (res.error != null) {
        debugPrint(
          'Error retriving the public url, error: \${res.error?.message}',
        );
      } else if (res.data != null) {
        setState(() {
          $varName2 = res.data!;
        });
      }
''';
  }
}
