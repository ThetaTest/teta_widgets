import 'package:flutter/material.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/qonversion/buy/action.dart';
import '../../../actions/qonversion/restore/action.dart';
import 'widgets/buy.dart';
import 'widgets/restore.dart';

class TAQonversionControl extends StatelessWidget {
  const TAQonversionControl({
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
        if (action is TAQonversionBuy)
          QonversionBuyControl(
            action: action as TAQonversionBuy,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAQonversionRestore)
          QonversionRestoreControl(
            action: action as TAQonversionRestore,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
