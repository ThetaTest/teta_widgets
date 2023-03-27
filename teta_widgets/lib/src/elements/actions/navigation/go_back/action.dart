import 'package:flutter/material.dart';
import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TANavigationGoBack extends TetaAction {
  TANavigationGoBack({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationGoBack.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TANavigationGoBackParams(),
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
  TANavigationGoBackParams get params =>
      super.params as TANavigationGoBackParams;

  @override
  TetaActionType get type => TetaActionType.navigationGoBack;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    Navigator.pop(context);
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''Navigator.of(context, rootNavigator: true).pop(null);''';
  }
}
