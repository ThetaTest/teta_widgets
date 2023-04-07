import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/actions/navigation/launch_url/action.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_bottom_sheet/action.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_date_picker/action.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_snack/action.dart';
import 'package:teta_widgets/src/elements/actions/navigation/share/action.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/navigation/open_page/action.dart';
import 'widgets/launch_url.dart';
import 'widgets/open_bottom_sheet.dart';
import 'widgets/open_date_picker.dart';
import 'widgets/open_page.dart';
import 'widgets/open_snackbar.dart';
import 'widgets/share.dart';

class TANavigationControl extends StatelessWidget {
  const TANavigationControl({
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
        if (action is TANavigationLaunchUrl)
          NavigationLaunchUrlControl(
            action: action as TANavigationLaunchUrl,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TANavigationOpenPage)
          NavigationOpenPageControl(
            action: action as TANavigationOpenPage,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TANavigationOpenBottomSheet)
          NavigationOpenBottomSheetControl(
            action: action as TANavigationOpenBottomSheet,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TANavigationOpenDatePicker)
          NavigationOpenDatePickerControl(
            action: action as TANavigationOpenDatePicker,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TANavigationOpenSnackBar)
          NavigationOpenSnackBarControl(
            action: action as TANavigationOpenSnackBar,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TANavigationShare)
          NavigationShareControl(
            action: action as TANavigationShare,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
