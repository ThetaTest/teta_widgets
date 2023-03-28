import 'package:flutter/material.dart';

import '../../../elements/features/text_type_input.dart';
import '../../teta_widget/index.dart';

class TetaActionCondition {
  const TetaActionCondition({
    required this.condition,
    required this.valueOfCondition,
  });

  TetaActionCondition.fromJson(
    final Map<String, dynamic> json,
  )   : condition = json['condition'] != null
            ? FTextTypeInput.fromJson(json['condition'] as Map<String, dynamic>)
            : null,
        valueOfCondition = json['valueOfCondition'] != null
            ? FTextTypeInput.fromJson(
                json['valueOfCondition'] as Map<String, dynamic>,
              )
            : null;

  final FTextTypeInput? condition;
  final FTextTypeInput? valueOfCondition;

  bool isConditionValid(
    final BuildContext context,
    final TetaWidgetState state,
  ) {
    return condition?.get(
          state.params,
          state.states,
          state.dataset,
          state.forPlay,
          state.loop,
          context,
        ) ==
        valueOfCondition?.get(
          state.params,
          state.states,
          state.dataset,
          state.forPlay,
          state.loop,
          context,
        );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'condition': condition?.toJson(),
        'valueOfCondition': valueOfCondition?.toJson(),
      };

  TetaActionCondition copyWith({
    final FTextTypeInput? condition,
    final FTextTypeInput? valueOfCondition,
  }) =>
      TetaActionCondition(
        condition: condition ?? this.condition,
        valueOfCondition: valueOfCondition ?? this.valueOfCondition,
      );
}
