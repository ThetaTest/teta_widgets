import 'package:flutter/material.dart';

import '../../../../actions/navigation/open_bottom_sheet/action.dart';
import '../../../../actions/navigation/open_bottom_sheet/params.dart';
import '../../component_selector.dart';

class NavigationOpenBottomSheetControl extends StatefulWidget {
  const NavigationOpenBottomSheetControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TANavigationOpenBottomSheet action;
  final Function(TANavigationOpenBottomSheetParams params) onParamsChanged;

  @override
  State<NavigationOpenBottomSheetControl> createState() =>
      NavigationOpenBottomSheetControlState();
}

class NavigationOpenBottomSheetControlState
    extends State<NavigationOpenBottomSheetControl> {
  String? nameOfPage;
  Map<String, dynamic>? paramsToSend;

  @override
  void initState() {
    super.initState();
    nameOfPage = widget.action.params.nameOfPage;
    paramsToSend = widget.action.params.paramsToSend;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TANavigationOpenBottomSheetParams(
          nameOfPage: nameOfPage,
          paramsToSend: paramsToSend,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    return ComponentSelector(
      pageToOpen: nameOfPage,
      paramsToSend: paramsToSend,
      onParamsChanged: (pageToOpen, paramsToSend) {
        nameOfPage = pageToOpen;
        this.paramsToSend = paramsToSend;
        updateParams();
      },
    );
  }
}
