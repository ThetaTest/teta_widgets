// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teta_core/src/design_system/switch.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/teta_core.dart';

class FlagControl extends StatefulWidget {
  const FlagControl({
    required this.title,
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String title;
  final bool value;
  final Function(bool, bool) callBack;

  @override
  FlagControlState createState() => FlagControlState();
}

class FlagControlState extends State<FlagControl> {
  bool switchOn = false;

  @override
  void initState() {
    super.initState();
    switchOn = widget.value;
  }

  void _onSwitchChanged(final bool value) {
    setState(() {
      switchOn = value;
    });
    widget.callBack(value, widget.value);
  }

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(
          widget.title,
          typography: const CTypo.extraBold16(),
        ),
        CSwitch(
          callback: _onSwitchChanged,
          value: switchOn,
        ),
      ],
    );
  }
}
