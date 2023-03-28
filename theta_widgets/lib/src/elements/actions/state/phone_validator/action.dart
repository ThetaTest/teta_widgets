import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import '../../snippets/update_state_value.dart';
import 'params.dart';

class TAStatePhoneValidator extends TetaAction {
  TAStatePhoneValidator({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStatePhoneValidator.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStatePhoneValidatorParams.fromJson(
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
  TAStatePhoneValidatorParams get params =>
      super.params as TAStatePhoneValidatorParams;

  @override
  TetaActionType get type => TetaActionType.statePhoneValidator;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.stateName2 == null) return;
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final index = pageState.states.indexWhere(
      (final element) => element.name == params.stateName,
    );
    if (index >= 0) {
      const patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      final regExp = RegExp(patttern);
      var value = '';
      if ('${pageState.states[index].value}'.isEmpty) {
        value = 'false';
      } else if (!regExp.hasMatch('${pageState.states[index].value}')) {
        value = 'false';
      } else {
        value = 'true';
      }
      updateStateValue(context, params.stateName2!, value);
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
      const patttern = r'(^(?:[+0]9)?[0-9]{10,12}\$)';
      final regExp = RegExp(patttern);
      if ('\$$varName'.isEmpty) {
        setState(() {
          $varName2 = 'false';
        });
      } else if (!regExp.hasMatch('\$$varName')) {
        setState(() {
          $varName2 = 'false';
        });
      } else {
        setState(() {
          $varName2 = 'true';
        });
      }
      ''';
  }
}
