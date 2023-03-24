import 'package:flutter/material.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/revenue_cat/buy/action.dart';
import '../../../actions/revenue_cat/restore/action.dart';
import '../../../index.dart';
import 'widgets/buy.dart';
import 'widgets/restore.dart';

class TARevenueCatControl extends StatelessWidget {
  const TARevenueCatControl({
    super.key,
    required this.project,
    required this.page,
    required this.node,
    required this.action,
    required this.onParamsChanged,
  });

  final ProjectObject project;
  final PageObject page;
  final CNode node;
  final TetaAction action;
  final Function(TetaActionParams params) onParamsChanged;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (action is TARevenueCatBuy)
          RevenueCatBuyControl(
            action: action as TARevenueCatBuy,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TARevenueCatRestore)
          RevenueCatRestoreControl(
            action: action as TARevenueCatRestore,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
