// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/supabase_map_element.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

class FACameraSwitch {
  static Future action(
    BuildContext context,
    String? stateName,
    List<SupabaseMapElement>? supabaseData,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop,
  ) async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final state = page.states
        .firstWhereOrNull((e) => e.type == VariableType.cameraController);
    final controller = state?.controller;
    if (controller != null) {
      //controller.

    }
  }

  static String toCode(
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final status = takeStateFrom(page, 'status');
    return '''
    ${status != null ? "setState(() { status = 'Loading'; });" : ''}
    final response = await supabase.auth.signIn(provider: Provider.apple);
    if (response.error != null) {
      ${status != null ? "setState(() { status = 'Failed'; });" : ''}
    } else {
      ${status != null ? "setState(() { status = 'Success'; });" : ''}
      ${FActionNavigationOpenPage.toCode(context, nameOfPage, paramsToSend)}
    }
    ''';
  }
}
