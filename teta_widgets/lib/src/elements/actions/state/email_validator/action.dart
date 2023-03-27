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

class TAStateEmailValidator extends TetaAction {
  TAStateEmailValidator({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStateEmailValidator.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStateEmailValidatorParams.fromJson(
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
  TAStateEmailValidatorParams get params =>
      super.params as TAStateEmailValidatorParams;

  @override
  TetaActionType get type => TetaActionType.stateEmailValidator;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    final index = pageLoaded.states.indexWhere(
      (final element) => element.name == params.stateName,
    );
    if (index >= 0) {
      final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      );
      updateStateValue(
        context,
        params.stateName2!,
        '${emailRegex.hasMatch('${state.states[index].get}')}',
      );
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

    const regex = r'''
const pattern =
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
        final regex = RegExp(pattern);
''';
    return '''
      $regex
      if (!regExp.hasMatch('\$$varName')) {
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
