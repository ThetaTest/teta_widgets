// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/supabase_map_element.dart';
import 'package:teta_core/src/models/variable.dart';

class FACameraTakePhoto {
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
      final file = await controller.takePicture();
      final index = states.indexWhere((element) => element.name == stateName);
      states[index].file = file;
    }
  }

  static String toCode(
    BuildContext context,
    String? stateName,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final state = page.states
        .firstWhereOrNull((e) => e.type == VariableType.cameraController);
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
