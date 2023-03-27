import 'package:flutter/material.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/cutom_http_request/delete/action.dart';
import '../../../actions/cutom_http_request/post/action.dart';
import '../../../actions/cutom_http_request/update/action.dart';
import 'widget/delete.dart';
import 'widget/post.dart';
import 'widget/update.dart';

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
        if (action is TACustomHttpRequestDelete)
          CustomHttpRequestDeleteControl(
            action: action as TACustomHttpRequestDelete,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TACustomHttpRequestPost)
          CustomHttpRequestPostControl(
            action: action as TACustomHttpRequestPost,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TACustomHttpRequestUpdate)
          CustomHttpRequestUpdateControl(
            action: action as TACustomHttpRequestUpdate,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
