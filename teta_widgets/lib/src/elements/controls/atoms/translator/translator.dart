import 'package:flutter/material.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/translator/translate/action.dart';
import 'widgets/translate.dart';

class TATranslatorControl extends StatelessWidget {
  const TATranslatorControl({
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
        if (action is TATranslatorTranslate)
          TranslatorTranslateControl(
            action: action as TATranslatorTranslate,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
