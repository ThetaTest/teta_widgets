// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/font_weight.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FontWeightControl extends StatefulWidget {
  const FontWeightControl({
    required this.textStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextStyle textStyle;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  FontWeightControlState createState() => FontWeightControlState();
}

class FontWeightControlState extends State<FontWeightControl> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.textStyle.fontWeight!.getString;
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: TParagraph(
            'Font Weight',
          ),
        ),
        CDropdown(
          value: dropdown,
          items: FFontWeight.getListDropDown,
          onChange: (final newValue) {
            if (newValue != null) {
              setState(() {
                dropdown = newValue;
              });
              final old = FTextStyle.fromJson(widget.textStyle.toJson());
              widget.textStyle.fontWeight!.set(newValue);
              widget.callBack(widget.textStyle.toJson(), old.toJson());
            }
          },
        ),
      ],
    );
  }
}
