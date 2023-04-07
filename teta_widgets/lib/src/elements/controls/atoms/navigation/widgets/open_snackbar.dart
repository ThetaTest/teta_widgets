import 'package:flutter/material.dart';

import '../../../../actions/navigation/open_snack/action.dart';
import '../../../../actions/navigation/open_snack/params.dart';
import '../../destination_page_selector.dart';

class NavigationOpenSnackBarControl extends StatefulWidget {
  const NavigationOpenSnackBarControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TANavigationOpenSnackBar action;
  final Function(TANavigationOpenSnackBarParams params) onParamsChanged;

  @override
  State<NavigationOpenSnackBarControl> createState() =>
      NavigationOpenSnackBarControlState();
}

class NavigationOpenSnackBarControlState
    extends State<NavigationOpenSnackBarControl> {
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
        TANavigationOpenSnackBarParams(
          nameOfPage: nameOfPage,
          paramsToSend: paramsToSend,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    return DestinationPageSelector(
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
