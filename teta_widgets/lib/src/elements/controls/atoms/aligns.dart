// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_widgets/src/elements/features/align.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class AlignsControl extends StatefulWidget {
  const AlignsControl({
    Key? key,
    required this.node,
    required this.align,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final FAlign align;
  final Function(FAlign, FAlign) callBack;

  @override
  AlignsControlState createState() => AlignsControlState();
}

class AlignsControlState extends State<AlignsControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = 'Top Left';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: CText(
            'Align with the parent',
            color: Palette.white,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CDropdown(
                value: widget.align.getStringForDropDown(context),
                items: FAlign.dropdownList,
                onChange: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    final old = FAlign.fromJson(widget.align.toJson());
                    final align = widget.align.copyWith(
                      align: FAlign.convertDropDownToValue(newValue),
                    );
                    widget.callBack(align, old);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
