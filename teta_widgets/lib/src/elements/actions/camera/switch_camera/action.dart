import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../navigation/open_page/action.dart';
import '../../navigation/open_page/params.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TACameraSwitchCamera extends TetaAction {
  TACameraSwitchCamera({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TACameraSwitchCamera.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TACameraSwitchCameraParams.fromJson(
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
  TACameraSwitchCameraParams get params =>
      super.params as TACameraSwitchCameraParams;

  @override
  TetaActionType get type => TetaActionType.cameraSwitchCamera;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final state = page.states.firstWhereOrNull(
      (final e) => e.type == VariableType.cameraController,
    );
    final controller = state?.controller;
    if (controller != null) {
      //controller.
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    final status = takeStateFrom(page, 'status');
    return '''
    ${status != null ? "setState(() { status = 'Loading'; });" : ''}
    final response = await supabase.auth.signIn(provider: Provider.apple);
    if (response.error != null) {
      ${status != null ? "setState(() { status = 'Failed'; });" : ''}
    } else {
      ${status != null ? "setState(() { status = 'Success'; });" : ''}
      ${TANavigationOpenPage(
      params: TANavigationOpenPageParams(
        nameOfPage: params.nameOfPage,
        paramsToSend: params.paramsToSend,
      ),
    ).toCode(context, pageId, loop)}
    }
    ''';
  }
}
