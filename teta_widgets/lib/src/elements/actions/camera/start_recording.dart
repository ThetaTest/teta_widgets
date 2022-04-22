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

class FACameraStartRecording {
  static Future action(
    final BuildContext context,
    final String? stateName,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final state =
        states.firstWhereOrNull((final element) => element.name == stateName);
    final controller = state?.controller;
    if (controller != null) {
      if (!controller.value.isRecordingVideo) {
        await controller.startVideoRecording();
      }
    }
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final state =
        page.states.firstWhereOrNull((final e) => e.name == stateName);
    if (state == null || stateName == null) return '';
    final rc = ReCase(state.name);
    return '''
    if (${rc.camelCase} != null) {
      if (${rc.camelCase}.value.isRecordingVideo) {
        await ${rc.camelCase}.startVideoRecording();
      }
    }
    ''';
  }
}
