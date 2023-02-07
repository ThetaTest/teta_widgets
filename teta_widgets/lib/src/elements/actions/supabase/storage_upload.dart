// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseStorageUpload {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
    final String? stateName,
    final String? stateName2,
    final int? loop,
  ) async {
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;

    final index = pageState.states
        .indexWhere((final element) => element.name == stateName);
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null && index != -1) {
      final bytes = await pageState.states[index].file?.readAsBytes();
      if (bytes == null || bytes.isEmpty) return;
      final response = await client.storage
          .from(
            supabaseFrom?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  loop,
                  context,
                ) ??
                '',
          )
          .uploadBinary(
            pathFile?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  loop,
                  context,
                ) ??
                '',
            bytes,
          );
      final index2 = pageState.states
          .indexWhere((final element) => element.name == stateName2);
      final res = client.storage
          .from(
            supabaseFrom?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  loop,
                  context,
                ) ??
                '',
          )
          .getPublicUrl(
            pathFile?.get(
                  pageState.params,
                  pageState.states,
                  pageState.datasets,
                  true,
                  loop,
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

  static String toCode(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
    final String stateName,
    final String stateName2,
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
    final varName = ReCase(stateName).camelCase;
    final varName2 = ReCase(stateName2).camelCase;
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
