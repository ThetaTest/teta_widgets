import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:theta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:theta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import '../../snippets/update_state_value.dart';
import 'params.dart';

class TAStatePasswordValidator extends TetaAction {
  TAStatePasswordValidator({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStatePasswordValidator.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStatePasswordValidatorParams.fromJson(
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
  TAStatePasswordValidatorParams get params =>
      super.params as TAStatePasswordValidatorParams;

  @override
  TetaActionType get type => TetaActionType.statePasswordValidator;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final index = pageState.states
        .indexWhere((final element) => element.name == params.stateName);
    if (index >= 0) {
      final numReg = RegExp('.*[0-9].*');
      final letterReg = RegExp('.*[A-Za-z].*');
      var value = '';
      if ('${pageState.states[index].value}'.isEmpty) {
        value = 'Please enter you password';
      } else if ('${pageState.states[index].value}'.length < 6) {
        value = 'Your password is too short';
      } else if ('${pageState.states[index].value}'.length < 8) {
        value = 'Your password is acceptable but not strong';
      } else {
        if (!letterReg.hasMatch('${pageState.states[index].value}') ||
            !numReg.hasMatch('${pageState.states[index].value}')) {
          value = 'Your password is strong';
        } else {
          value = 'Your password is great';
        }
      }
      updateStateValue(
        context,
        params.stateName2!,
        value,
      );
      return;
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    if (params.stateName == null || params.stateName2 == null) {
      return '';
    }
    final page = getPageOnToCode(pageId, context);
    final variable = takeStateFrom(page, params.stateName!);
    if (variable == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    final variable2 = takeStateFrom(page, params.stateName2!);
    if (variable2 == null) return '';

    final varName2 = ReCase(params.stateName2!).camelCase;

    return '''
      final numReg = RegExp('.*[0-9].*');
      final letterReg = RegExp('.*[A-Za-z].*');
      if ('\$$varName'.isEmpty) {
        $varName2 = 'Please enter you password';
      } else if ('\$$varName'.length < 6) {
        $varName2 = 'Your password is too short';
      } else if ('\$$varName'.length < 8) {
        $varName2 = 'Your password is acceptable but not strong';
      } else {
        if (!letterReg.hasMatch('\$$varName') ||
            !numReg.hasMatch('\$$varName')) {
          $varName2 = 'Your password is strong';
        } else {
          $varName2 = 'Your password is great';
        }
      }
    ''';
  }
}
