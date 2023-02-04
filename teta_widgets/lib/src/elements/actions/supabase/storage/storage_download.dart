// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseStorageDownload {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;

    // Take status from states
    final status = takeStateFrom(page, 'status');

    changeState(status, context, 'Loading');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final response = await client.storage
          .from(
            supabaseFrom?.get(
                  params,
                  states,
                  dataset,
                  true,
                  loop,
                  context,
                ) ??
                '',
          )
          .download(
            pathFile?.get(
                  params,
                  states,
                  dataset,
                  true,
                  loop,
                  context,
                ) ??
                '',
          );
      if (response.error != null) changeState(status, context, 'Failed');
      changeState(status, context, 'Success');
    }
  }

  static String toCode(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
    final int? loop,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    final from = supabaseFrom?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final path = pathFile?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    return '''
await Supabase.instance.client.storage.from($from).download([$path]);
if (res.error != null) {
  debugPrint(
    'Error retriving the public url, error: \${res.error?.message}',
  );
}
''';
  }
}
