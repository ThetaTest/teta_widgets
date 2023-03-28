import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/teta_widget_state.dart';
import '../../snippets/get_page_on_code.dart';
import 'params.dart';

class TACameraAlwaysFlash extends TetaAction {
  TACameraAlwaysFlash({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TACameraAlwaysFlash.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TACameraAlwaysFlashParams(),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TetaActionType get type => TetaActionType.cameraAlwaysFlash;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final state = page.states
        .firstWhereOrNull((final e) => e.type == VariableType.cameraController);
    final controller = state?.controller;
    if (controller != null) {
      await controller.setFlashMode(FlashMode.always);
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    final state = page.states
        .firstWhereOrNull((final e) => e.type == VariableType.cameraController);
    if (state == null) return '';
    final rc = ReCase(state.name);
    return '''
    ${rc.camelCase}.setFlashMode(FlashMode.always);
    ''';
  }
}
