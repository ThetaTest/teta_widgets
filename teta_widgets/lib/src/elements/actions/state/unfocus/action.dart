import 'package:flutter/material.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TAStateUnfocus extends TetaAction {
  TAStateUnfocus({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStateUnfocus.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TAStateUnfocusParams(),
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
  TAStateUnfocusParams get params => super.params as TAStateUnfocusParams;

  @override
  TetaActionType get type => TetaActionType.stateUnfocus;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async =>
      FocusScope.of(context).unfocus();

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) =>
      'FocusScope.of(context).unfocus();';
}
