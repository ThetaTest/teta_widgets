// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';

class FACameraStartRecording {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String? stateName,
  ) async {
    final stateFound = state.states.firstWhereOrNull((final element) => element.name == stateName);
    final controller = stateFound?.controller;
    if (controller != null) {
      if (!controller.value.isRecordingVideo) {
        await controller.startVideoRecording();
      }
    }
  }

  static String toCode(
    final BuildContext context,
    final int pageId,
    final String? stateName,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final state = page.states.firstWhereOrNull((final e) => e.name == stateName);
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
