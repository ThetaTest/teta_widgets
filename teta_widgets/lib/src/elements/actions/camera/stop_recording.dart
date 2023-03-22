// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_file.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class FACameraStopRecording {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String? stateName,
  ) async {
    if (stateName == null) return;
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final stateFound = page.states.firstWhereOrNull(
      (final e) => e.type == VariableType.cameraController,
    );
    final controller = stateFound?.controller;
    if (controller != null) {
      if (controller.value.isRecordingVideo) {
        final file = await controller.stopVideoRecording();
        updateStateFile(context, stateName, file);
      }
    }
  }

  static String toCode(
    final BuildContext context,
    final int pageId,
    final String? stateName,
  ) {
    final page = getPageOnToCode(pageId, context);
    final state = page.states
        .firstWhereOrNull((final e) => e.type == VariableType.cameraController);
    if (state == null || stateName == null) return '';
    final rc = ReCase(state.name);
    final fileStateName = ReCase(stateName);
    return '''
    if (${rc.camelCase} != null) {
      setState(() {
        ${fileStateName.camelCase} = await ${rc.camelCase}.stopVideoRecording();
      });
    }
    ''';
  }
}
