// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/box_fit.dart';

class BoxFitControl extends StatefulWidget {
  const BoxFitControl({
    required this.boxFit,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

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
  Widget build(final BuildContext context) {
    return CDropdown(
      value: dropdown,
      items: FBoxFit.dropdownList,
      onChange: (final newValue) {
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
