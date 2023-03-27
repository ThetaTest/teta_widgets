import 'package:flutter/material.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/airtable/delete/action.dart';
import '../../../actions/airtable/insert/action.dart';
import '../../../actions/airtable/update/action.dart';
import 'widgets/delete.dart';
import 'widgets/insert.dart';
import 'widgets/update.dart';

class TAAirtableControl extends StatelessWidget {
  const TAAirtableControl({
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
        if (action is TAAirtableDelete)
          AirtableDeleteControl(
            action: action as TAAirtableDelete,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAAirtableInsert)
          AirtableInsertControl(
            action: action as TAAirtableInsert,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TAAirtableUpdate)
          AirtableUpdateControl(
            action: action as TAAirtableUpdate,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
