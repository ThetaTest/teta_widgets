import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/actions/state/change_with_param/action.dart';
import 'package:teta_widgets/src/elements/actions/state/pick_file/action.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/params_index.dart';
import '../../../actions/state/change_with/action.dart';
import '../../../actions/state/decrement/action.dart';
import '../../../actions/state/email_validator/action.dart';
import '../../../actions/state/increment/action.dart';
import '../../../actions/state/password_validator/action.dart';
import '../../../actions/state/phone_validator/action.dart';
import '../../../actions/state/state_validator_params.dart';
import '../../../actions/state/website_validator/action.dart';
import 'widgets/change_with.dart';
import 'widgets/change_with_param.dart';
import 'widgets/decrement.dart';
import 'widgets/increment.dart';
import 'widgets/pick_file.dart';
import 'widgets/validator.dart';

class TAStateControl extends StatelessWidget {
  const TAStateControl({
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
        if (action is TAStateIncrement)
          StateIncrementControl(
            action: action as TAStateIncrement,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAStateDecrement)
          StateDecrementControl(
            action: action as TAStateDecrement,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAStateChangeWith)
          StateChangeWithControl(
            action: action as TAStateChangeWith,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAStateChangeWithParam)
          StateChangeWithParamControl(
            action: action as TAStateChangeWithParam,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAStatePickFile)
          StatePickFileControl(
            action: action as TAStatePickFile,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAStateWebsiteValidator ||
            action is TAStateEmailValidator ||
            action is TAStatePhoneValidator ||
            action is TAStatePasswordValidator)
          StateValidatorControl(
            params: action.params as StateValidatorParams,
            onStateNameChanged: (final stateName, final stateName2) {
              late final TetaActionParams params;
              switch (action.runtimeType) {
                case TAStateWebsiteValidator:
                  params = TAStateWebsiteValidatorParams(
                    stateName: stateName,
                    stateName2: stateName2,
                  );
                  break;
                case TAStateEmailValidator:
                  params = TAStateEmailValidatorParams(
                    stateName: stateName,
                    stateName2: stateName2,
                  );
                  break;
                case TAStatePhoneValidator:
                  params = TAStatePhoneValidatorParams(
                    stateName: stateName,
                    stateName2: stateName2,
                  );
                  break;
                case TAStatePasswordValidator:
                  params = TAStatePasswordValidatorParams(
                    stateName: stateName,
                    stateName2: stateName2,
                  );
                  break;
              }
              onParamsChanged(params);
            },
          ),
      ],
    );
  }
}
