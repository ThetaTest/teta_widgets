import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TAChangeTheme extends TetaAction {
  TAChangeTheme({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAChangeTheme.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TAChangeThemeParams(),
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
  TAChangeThemeParams get params => super.params as TAChangeThemeParams;

  @override
  TetaActionType get type => TetaActionType.themeChangeTheme;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    BlocProvider.of<PaletteDarkLightCubit>(context).switchVal();
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return 'BlocProvider.of<ThemeCubit>(context).changeVal();';
  }
}
