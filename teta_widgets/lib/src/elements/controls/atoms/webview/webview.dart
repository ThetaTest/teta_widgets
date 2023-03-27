import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/actions/actions_index.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import 'widgets/back.dart';
import 'widgets/forward.dart';
import 'widgets/navigate_to.dart';
import 'widgets/reload.dart';

class TAWebViewControl extends StatelessWidget {
  const TAWebViewControl({
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
        if (action is TAWebViewNavigateTo)
          WebViewNavigateToControl(
            action: action as TAWebViewNavigateTo,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAWebViewGoBack)
          WebViewGoBackControl(
            action: action as TAWebViewGoBack,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAWebViewGoForward)
          WebViewGoForwardControl(
            action: action as TAWebViewGoForward,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAWebViewReload)
          WebViewReloadControl(
            action: action as TAWebViewReload,
            onParamsChanged: onParamsChanged,
          )
      ],
    );
  }
}
