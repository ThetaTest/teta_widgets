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
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';

class FACameraTakePhoto {
  static Future action(
    final BuildContext context,
    final String? stateName,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final page = BlocProvider.of<PageCubit>(context).state;
    final state = page.states
        .firstWhereOrNull((final e) => e.type == VariableType.cameraController);
    final controller = state?.controller;
    if (controller != null) {
      final file = await controller.takePicture();
      final index =
          states.indexWhere((final element) => element.name == stateName);
      states[index].file = file;
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
        ${fileStateName.camelCase} = await ${rc.camelCase}.takePicture();
      });
    }
    ''';
  }
}
