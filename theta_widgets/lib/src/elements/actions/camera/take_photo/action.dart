import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/update_state_file.dart';
import 'params.dart';

class TACameraTakePhoto extends TetaAction {
  TACameraTakePhoto({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TACameraTakePhoto.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TACameraTakePhotoParams.fromJson(
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
  TACameraTakePhotoParams get params => super.params as TACameraTakePhotoParams;

  @override
  TetaActionType get type => TetaActionType.cameraTakePhoto;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.stateName == null) return;
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final stateFound = page.states.firstWhereOrNull(
      (final e) => e.type == VariableType.cameraController,
    );
    final controller = stateFound?.controller;
    if (controller != null) {
      final file = await controller.takePicture();
      updateStateFile(context, params.stateName!, file);
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
      (final e) => e.type == VariableType.cameraController,
    );
    if (state == null || params.stateName == null) return '';
    final rc = ReCase(state.name);
    final fileStateName = ReCase(params.stateName!);
    return '''
    if (${rc.camelCase} != null) {
      setState(() {
        ${fileStateName.camelCase} = await ${rc.camelCase}.takePicture();
      });
    }
    ''';
  }
}
