import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../teta_widget/teta_widget_state.dart';
import 'teta_action.dart';

abstract class TetaActionExecutor {
  static Future<void> executeAction(
    final BuildContext context,
    final TetaAction? action,
    final TetaWidgetState state,
    final String? runtimeValue,
  ) async {
    if (action == null) return;

    // 1. Executes the action only if the condition is valid
    if (action.condition != null &&
        !action.condition!.isConditionValid(context, state)) {
      return;
    }

    // 2. Waits for the delay, if any
    if (action.delay != 0) {
      await Future<void>.delayed(Duration(milliseconds: action.delay));
    }

    // 3. Executes the action in loop, if any, or just once
    if (action.loop != null) {
      BlocProvider.of<ActiveActionsTimers>(context).add(
        Timer.periodic(
          Duration(milliseconds: action.loop!.interval),
          (final Timer t) {
            action.execute(context, state, runtimeValue: runtimeValue);
          },
        ),
      );
    } else {
      await action.execute(context, state, runtimeValue: runtimeValue);
    }
  }
}
