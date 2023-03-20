// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_front_end/teta_front_end.dart';

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
    controller = TextEditingController();
    controller.text = widget.value.key;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: TParagraph(
            'Key',
          ),
        ),
        CTextField(
          //text: text,
          controller: controller,
          callBack: (final value) {
            final old = widget.value;
            final newValue = widget.value.copyWith(key: value);
            widget.callBack(newValue, old);
          },
        ),
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
