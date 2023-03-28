import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class HttpParamsElementControl extends StatefulWidget {
  const HttpParamsElementControl({
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final MapElement value;
  final Function(MapElement, MapElement) callBack;

  @override
  HttpParamsElementControlState createState() =>
      HttpParamsElementControlState();
}

class HttpParamsElementControlState extends State<HttpParamsElementControl> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController()..text = widget.value.key;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TParagraph('Key'),
        const SizedBox(height: 8),
        CTextField(
          controller: controller,
          callBack: (final value) {
            final old = widget.value;
            final newValue = widget.value.copyWith(key: value);
            widget.callBack(newValue, old);
          },
        ),
        const Gap(Grid.medium),
        TextControl(
          ignoreDeviceTypeValue: true,
          valueType: VariableType.dynamic,
          value: widget.value.value,
          title: 'Value',
          callBack: (final value, final old) {
            final newValue = widget.value.copyWith(value: value);
            widget.callBack(newValue, widget.value);
          },
        ),
      ],
    );
  }
}
