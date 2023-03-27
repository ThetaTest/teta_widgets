import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_widgets/src/elements/controls/atoms/webview/widgets/webview_controller_state_dropdown.dart';

import '../../../../actions/webview/forward/action.dart';
import '../../../../actions/webview/forward/params.dart';

class WebViewGoForwardControl extends StatefulWidget {
  const WebViewGoForwardControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAWebViewGoForward action;
  final Function(TAWebViewGoForwardParams params) onParamsChanged;

  @override
  State<WebViewGoForwardControl> createState() =>
      WebViewGoForwardControlState();
}

class WebViewGoForwardControlState extends State<WebViewGoForwardControl> {
  String? stateName;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
  }

  void updateParams() {
    widget.onParamsChanged(
      TAWebViewGoForwardParams(
        stateName: stateName,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(Grid.medium),
        const TParagraph('Select the WebView controller'),
        const Gap(Grid.small),
        WebViewControllerStateDropdown(
          initialValue: stateName,
          onParamsChanged: (final newValue) {
            if (newValue != null) {
              stateName = newValue;
              updateParams();
            }
          },
        ),
      ],
    );
  }
}
