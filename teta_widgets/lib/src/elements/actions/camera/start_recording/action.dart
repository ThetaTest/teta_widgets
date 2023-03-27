import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import 'params.dart';

class TACameraStartRecording extends TetaAction {
  TACameraStartRecording({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TACameraStartRecording.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TACameraStartRecordingParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
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
  TACameraStartRecordingParams get params =>
      super.params as TACameraStartRecordingParams;

  @override
  TetaActionType get type => TetaActionType.cameraStartRecoring;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final stateFound = state.states.firstWhereOrNull(
      (final element) => element.name == params.stateName,
    );
    final controller = stateFound?.controller;
    if (controller != null) {
      if (!controller.value.isRecordingVideo) {
        await controller.startVideoRecording();
      }
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    final state = page.states.firstWhereOrNull(
      (final e) => e.name == params.stateName,
    );
    if (state == null || params.stateName == null) return '';
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
