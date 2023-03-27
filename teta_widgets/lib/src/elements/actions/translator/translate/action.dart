import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TATranslatorTranslate extends TetaAction {
  TATranslatorTranslate({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TATranslatorTranslate.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TATranslatorTranslateParams.fromJson(
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
  TATranslatorTranslateParams get params =>
      super.params as TATranslatorTranslateParams;

  @override
  TetaActionType get type => TetaActionType.translatorTranslate;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final index = state.states.indexWhere(
      (final element) => element.name == params.stateName,
    );
    if (index != -1) {
      BlocProvider.of<TranslatorGeneratorCubit>(context)
          .state
          .instance
          .translate(state.states[index].get as String? ?? 'en');
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    if (params.stateName == null) return '';

    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, params.stateName!);
    if (variable == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    return '''
    TranslatorGenerator.instance.translate($varName);
    ''';
  }
}
