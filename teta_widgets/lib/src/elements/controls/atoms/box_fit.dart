// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
import 'package:teta_widgets/src/elements/features/box_fit.dart';

class BoxFitControl extends StatefulWidget {
  const BoxFitControl({Key? key, required this.boxFit, required this.callBack})
      : super(key: key);

  final FBoxFit boxFit;
  final Function(FBoxFit, FBoxFit) callBack;

  @override
  BoxFitControlState createState() => BoxFitControlState();
}

class BoxFitControlState extends State<BoxFitControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.boxFit.getString;
  }

  @override
  Widget build(BuildContext context) {
    return CDropdown(
      value: dropdown,
      items: FBoxFit.dropdownList,
      onChange: (newValue) {
        if (newValue != null) {
          setState(() {
            dropdown = newValue;
          });
          final old = widget.boxFit.clone();
          widget.boxFit.fit = FBoxFit.convertDropdownToValue(newValue);
          widget.callBack(widget.boxFit, old);
        }
      },
    );
  }
}
