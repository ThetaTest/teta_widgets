// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/supabase_map_element.dart';
import 'package:teta_core/src/models/variable.dart';

class FACameraTorchFlash {
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
      await controller.setFlashMode(FlashMode.torch);
    }
  }

  static String toCode(
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final state = page.states
        .firstWhereOrNull((e) => e.type == VariableType.cameraController);
    if (state == null) return '';
    final rc = ReCase(state.name);
    return '''
    ${rc.camelCase}.setFlashMode(FlashMode.torch);
    ''';
  }
}
