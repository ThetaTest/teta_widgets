import 'package:flutter/material.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/api_calls/execute/action.dart';
import 'widgets/execute.dart';

class TAApiCallsControl extends StatelessWidget {
  const TAApiCallsControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TetaAction action;
  final Function(TetaActionParams params) onParamsChanged;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (action is TAApiCallsExecute)
          ApiCallsExecuteControl(
            action: action as TAApiCallsExecute,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
