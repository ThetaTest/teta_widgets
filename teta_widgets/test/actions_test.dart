import 'package:teta_widgets/src/elements/actions/navigation/go_back.dart';
import 'package:teta_widgets/src/elements/actions/navigation/launch_url.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_bottom_sheet.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_date_picker.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_drawer.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_snack.dart';

///Tests for all actions
void main() {
  //Navigation
  NodeGestureActionsNavigationGoBack.testActionCode();
  NodeGestureActionsNavigationLaunchURL.testActionCode();
  NodeGestureActionsNavigationOpenBottomSheet.testActionCode();
  NodeGestureActionsNavigationOpenDatePicker.testActionCode();
  NodeGestureActionsNavigationOpenDrawer.testActionCode();
  NodeGestureActionsNavigationOpenPage.testActionCode();
  NodeGestureActionsNavigationOpenSnackBar.testActionCode();
}
