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
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class FASupabaseStorageUpload {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
    final String? stateName,
    final String? stateName2,
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
      if (bytes == null || bytes.isEmpty) return;
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
          .uploadBinary(
            pathFile?.get(
                  params,
                  states,
                  dataset,
                  true,
                  loop,
                  context,
                ) ??
                '',
            bytes,
          );
      if (response.error != null) changeState(status, context, 'Failed');
      final index2 =
          states.indexWhere((final element) => element.name == stateName2);
      final res = client.storage
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
          .getPublicUrl(
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
      if (res.error != null) {
        Logger.printError(
          'Error retriving the public url from just uploaded file, error: ${res.error?.message}',
        );
      } else if (res.data != null) {
        changeState(states[index2], context, res.data!);
      }
      changeState(status, context, 'Success');
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
    final page = BlocProvider.of<PageCubit>(context).state;
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
final bytes = $varName.readAsBytes();
await Supabase.instance.client.storage.from($from).uploadBinary($path,bytes);
final res = client.storage.from($from).getPublicUrl($path);
if (res.error != null) {
  Logger.printError(
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
