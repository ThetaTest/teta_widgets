import 'package:flutter/material.dart';

import '../../../../actions/navigation/open_page/action.dart';
import '../../../../actions/navigation/open_page/params.dart';
import '../../destination_page_selector.dart';

class NavigationOpenPageControl extends StatefulWidget {
  const NavigationOpenPageControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TANavigationOpenPage action;
  final Function(TANavigationOpenPageParams params) onParamsChanged;

  @override
  State<NavigationOpenPageControl> createState() =>
      NavigationOpenPageControlState();
}

class NavigationOpenPageControlState extends State<NavigationOpenPageControl> {
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
        TANavigationOpenPageParams(
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
