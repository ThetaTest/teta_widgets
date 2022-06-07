// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';

class FACameraStopRecording {
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
      if (controller.value.isRecordingVideo) {
        final file = await controller.stopVideoRecording();
        final index =
            states.indexWhere((final element) => element.name == stateName);
        states[index].file = file;
      }
    }
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? stateName,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
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
