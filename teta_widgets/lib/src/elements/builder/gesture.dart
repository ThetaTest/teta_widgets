// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Builder
class GestureBuilder {
  /// Get a gesture code based on FAction
  static void get({
    required final BuildContext context,
    required final CNode node,
    required final ActionGesture gesture,
    required final FTextTypeInput? actionValue,
    required final FAction? action,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    final int? loop,
  }) {
    if (forPlay) {
      String? finalValue;
      if (actionValue != null) {
        finalValue = actionValue.get(
          params,
          states,
          dataset,
          forPlay,
          loop,
          context,
        );
      }
      if (action != null) {
        action.actions!.where((final element) => element.actionGesture == gesture).forEach(
          (final element) {
            element.getAction(
              context,
              state,
              finalValue,
              BlocProvider.of<PageCubit>(context).state.scaffold!,
              node,
              params,
              states,
              dataset,
              loop,
            );
            Logger.printMessage('Action performed');
          },
        );
      }
    }
  }
}
