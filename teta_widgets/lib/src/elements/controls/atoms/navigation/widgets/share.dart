import 'package:flutter/material.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../../teta_widgets.dart';
import '../../../../actions/navigation/share/action.dart';
import '../../../../actions/navigation/share/params.dart';
import '../../../atoms/text.dart';

class NavigationShareControl extends StatefulWidget {
  const NavigationShareControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TANavigationShare action;
  final Function(TANavigationShareParams params) onParamsChanged;

  @override
  State<NavigationShareControl> createState() => NavigationShareControlState();
}

class NavigationShareControlState extends State<NavigationShareControl> {
  FTextTypeInput? value;

  @override
  void initState() {
    super.initState();
    value = widget.action.params.value;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TANavigationShareParams(
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
        child: TextControl(
          valueType: VariableType.string,
          value: widget.action.params.value ?? FTextTypeInput(),
          title: 'Value',
          callBack: (final newValue, final old) {
            value = newValue;
            updateParams();
          },
        ),
      ),
    );
  }
}
