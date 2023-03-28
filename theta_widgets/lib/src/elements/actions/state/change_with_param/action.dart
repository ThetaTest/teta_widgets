import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_param_from.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAStateChangeWithParam extends TetaAction {
  TAStateChangeWithParam({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStateChangeWithParam.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStateChangeWithParamParams.fromJson(
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
  TAStateChangeWithParamParams get params =>
      super.params as TAStateChangeWithParamParams;

  @override
  TetaActionType get type => TetaActionType.stateChangeWithParam;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.stateName == null) return;
    if (params.paramName == null) return;
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final index = pageState.states.indexWhere(
      (final element) => element.name == params.stateName,
    );
    final indexParam = pageState.params.indexWhere(
      (final element) => element.name == params.paramName,
    );
    final variable = pageState.states[index].copyWith(
      value: pageState.params[indexParam].value ??
          pageState.params[indexParam].defaultValue,
      controller: pageState.params[index].controller,
      file: pageState.params[index].file,
      webViewController: pageState.params[index].webViewController,
    );
    context.read<PageCubit>().updateState(variable);
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    final variable = takeStateFrom(page, '${params.stateName}');
    final param = takeParamFrom(page, '${params.paramName}');
    if (param == null ||
        params.stateName == null ||
        variable == null ||
        params.paramName == null) return '';

    final varName = ReCase(params.stateName!).camelCase;
    final paramName = ReCase(params.paramName!).camelCase;

    final buffer = StringBuffer()..write('');
    if (variable.type == VariableType.string) {
      buffer.write("$varName = '''$paramName''';");
    } else {
      if (variable.type == VariableType.int) {
        buffer.write(
          '$varName = $paramName;',
        );
      } else if (variable.type == VariableType.double) {
        buffer.write(
          '$varName = $paramName;',
        );
      } else {
        return '';
      }
    }

    return '''
    setState(() {
      ${buffer.toString()}
    });
    ''';
  }
}
