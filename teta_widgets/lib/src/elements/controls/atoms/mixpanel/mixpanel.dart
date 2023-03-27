import 'package:flutter/material.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/mixpanel/set_user_id/action.dart';
import '../../../actions/mixpanel/track/action.dart';
import 'widgets/set_user_id.dart';
import 'widgets/track.dart';

class TACustomHttpRequestControl extends StatelessWidget {
  const TACustomHttpRequestControl({
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
        if (action is TAMixpanelTrack)
          MixpanelTrackControl(
            action: action as TAMixpanelTrack,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAMixpanelSetUserId)
          MixpanelSetUserIdControl(
            action: action as TAMixpanelSetUserId,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
