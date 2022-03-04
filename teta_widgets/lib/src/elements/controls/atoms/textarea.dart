// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class TextAreaControl extends StatefulWidget {
  const TextAreaControl({
    required this.value,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final FTextTypeInput value;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<TextAreaControl> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    try {
      controller.text = widget.value.value!;
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CText(
          'Code',
          color: Palette.white,
          size: 12,
        ),
        CTextField(
          text: widget.value.value,
          controller: controller,
          maxLines: 10,
          callBack: (value) {
            final old = widget.value;
            widget.value.value = value;
            widget.callBack(widget.value, old);
          },
        ),
      ],
    );
  }
}
