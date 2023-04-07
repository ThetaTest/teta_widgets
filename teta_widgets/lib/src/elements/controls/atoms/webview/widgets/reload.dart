import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_widgets/src/elements/controls/atoms/webview/widgets/webview_controller_state_dropdown.dart';

import '../../../../actions/webview/reload/action.dart';
import '../../../../actions/webview/reload/params.dart';

class WebViewReloadControl extends StatefulWidget {
  const WebViewReloadControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAWebViewReload action;
  final Function(TAWebViewReloadParams params) onParamsChanged;

  @override
  State<WebViewReloadControl> createState() => WebViewReloadControlState();
}

class WebViewReloadControlState extends State<WebViewReloadControl> {
  String? stateName;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TAWebViewReloadParams(
          stateName: stateName,
        ),
      );
    });
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
