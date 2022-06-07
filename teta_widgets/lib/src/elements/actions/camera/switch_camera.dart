// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

class FACameraSwitch {
  static Future action(
    final BuildContext context,
    final String? stateName,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final state = page.states
        .firstWhereOrNull((final e) => e.type == VariableType.cameraController);
    final controller = state?.controller;
    if (controller != null) {
      //controller.

    }
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
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
