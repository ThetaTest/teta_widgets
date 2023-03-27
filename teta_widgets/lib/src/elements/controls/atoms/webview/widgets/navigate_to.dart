import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/elements/controls/atoms/webview/widgets/webview_controller_state_dropdown.dart';

import '../../../../actions/webview/navigate_to/action.dart';
import '../../../../actions/webview/navigate_to/params.dart';
import '../../../../features/text_type_input.dart';
import '../../text.dart';

class WebViewNavigateToControl extends StatefulWidget {
  const WebViewNavigateToControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAWebViewNavigateTo action;
  final Function(TAWebViewNavigateToParams params) onParamsChanged;

  @override
  State<WebViewNavigateToControl> createState() =>
      WebViewNavigateToControlState();
}

class WebViewNavigateToControlState extends State<WebViewNavigateToControl> {
  String? stateName;
  FTextTypeInput? url;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
    url = widget.action.params.url;
  }

  void updateParams() {
    widget.onParamsChanged(
      TAWebViewNavigateToParams(
        stateName: stateName,
        url: url,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: TextControl(
            valueType: VariableType.string,
            value: url ?? FTextTypeInput(),
            title: 'Url to navigate to',
            callBack: (final value, final old) {
              url = value;
              updateParams();
            },
          ),
        ),
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
