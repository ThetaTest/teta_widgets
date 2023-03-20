// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FACameraOffFlash {
  static Future action(final BuildContext context) async {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final state = page.states
        .firstWhereOrNull((final e) => e.type == VariableType.cameraController);
    final controller = state?.controller;
    if (controller != null) {
      await controller.setFlashMode(FlashMode.auto);
    }
  }

  static String toCode(
    final BuildContext context,
    final int pageId,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final state = page.states
        .firstWhereOrNull((final e) => e.type == VariableType.cameraController);
    if (state == null) return '';
    final rc = ReCase(state.name);
    return '''
    ${rc.camelCase}.setFlashMode(FlashMode.off);
    ''';
  }
}
