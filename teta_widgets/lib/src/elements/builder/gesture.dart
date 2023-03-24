import 'package:flutter/material.dart';

import '../../../teta_widgets.dart';
import '../../core/teta_widget/index.dart';

/// Builder
class GestureBuilder {
  /// Get a gesture code based on FAction
  static void get({
    required final BuildContext context,
    required final TetaWidgetState state,
    required final ActionGesture gesture,
    required final FTextTypeInput? actionValue,
    required final NodeGestureActions? nodeGestureActions,
  }) {
    if (state.forPlay && nodeGestureActions != null) {
      final runtimeValue = actionValue?.get(
        state.params,
        state.states,
        state.dataset,
        state.forPlay,
        state.loop,
        context,
      );

      nodeGestureActions.execute(
        context,
        gesture,
        state,
        runtimeValue,
      );
    }
  }
}
