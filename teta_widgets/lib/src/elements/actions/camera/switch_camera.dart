// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
// Package imports:
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class FACameraSwitch {
  static Future action(
    final BuildContext context,
    final String? stateName,
  ) async {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final state = page.states.firstWhereOrNull(
      (final e) => e.type == VariableType.cameraController,
    );
    final controller = state?.controller;
    if (controller != null) {
      //controller.
    }
  }

  static String toCode(
    final BuildContext context,
    final int pageId,
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
