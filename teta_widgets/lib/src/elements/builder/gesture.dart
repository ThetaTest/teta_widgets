// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

/// Builder
class GestureBuilder {
  /// Get a gesture code based on FAction
  static void get({
    required final BuildContext context,
    required final TetaWidgetState state,
    required final ActionGesture gesture,
    required final FTextTypeInput? actionValue,
    required final FAction? action,
  }) {
    if (state.forPlay) {
      String? finalValue;
      if (actionValue != null) {
        finalValue = actionValue.get(
          state.params,
          state.states,
          state.dataset,
          state.forPlay,
          state.loop,
          context,
        );
      }
      if (action != null) {
        action.actions!
            .where((final element) => element.actionGesture == gesture)
            .forEach(
          (final element) {
            element.getAction(
              context,
              state,
              finalValue,
              BlocProvider.of<PageCubit>(context).state.scaffold!,
            );
            Logger.printMessage('Action performed');
          },
        );
      }
    }
  }
}
