import 'package:flutter/material.dart';

import '../../../../core/teta_action/index.dart';
import '../../../actions/actions_index.dart';
import 'widgets/delete.dart';
import 'widgets/insert.dart';
import 'widgets/update.dart';

class TATetaCMSDatabaseControls extends StatelessWidget {
  const TATetaCMSDatabaseControls({
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
        if (action is TATetaCMSInsert)
          TetaCmsInsertControl(
            action: action as TATetaCMSInsert,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TATetaCMSUpdate)
          TetaCmsUpdateControl(
            action: action as TATetaCMSUpdate,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TATetaCMSDelete)
          TetaCmsDeleteControl(
            action: action as TATetaCMSDelete,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
