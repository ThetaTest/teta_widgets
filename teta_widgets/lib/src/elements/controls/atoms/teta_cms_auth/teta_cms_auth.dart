import 'package:flutter/material.dart';

import '../../../../core/teta_action/index.dart';
import '../../../actions/actions_index.dart';
import 'widgets/login.dart';
import 'widgets/logout.dart';

class TATetaCMSAuthControls extends StatelessWidget {
  const TATetaCMSAuthControls({
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
        if (action is TATetaCMSLogin)
          TetaCmsLoginControl(
            action: action as TATetaCMSLogin,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TATetaCMSLogout)
          TetaCmsLogoutControl(
            action: action as TATetaCMSLogout,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
