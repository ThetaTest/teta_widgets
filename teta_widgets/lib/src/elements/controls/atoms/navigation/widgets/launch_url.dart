import 'package:flutter/material.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../../teta_widgets.dart';
import '../../../../actions/navigation/launch_url/action.dart';
import '../../../../actions/navigation/launch_url/params.dart';
import '../../../atoms/text.dart';

class NavigationLaunchUrlControl extends StatefulWidget {
  const NavigationLaunchUrlControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TANavigationLaunchUrl action;
  final Function(TANavigationLaunchUrlParams params) onParamsChanged;

  @override
  State<NavigationLaunchUrlControl> createState() =>
      NavigationLaunchUrlControlState();
}

class NavigationLaunchUrlControlState
    extends State<NavigationLaunchUrlControl> {
  FTextTypeInput? value;

  @override
  void initState() {
    super.initState();
    value = widget.action.params.value;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TANavigationLaunchUrlParams(
          value: value,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: double.maxFinite,
        child: descriptionControlWidget(
          description: '''''',
          control: TextControl(
            valueType: VariableType.string,
            value: widget.action.params.value ?? FTextTypeInput(),
            title: 'URL to open',
            callBack: (final newValue, final old) {
              value = newValue;
              updateParams();
            },
          ),
        ),
      ),
    );
  }
}
