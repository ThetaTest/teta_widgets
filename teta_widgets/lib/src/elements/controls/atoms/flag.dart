// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/switch.dart';
import 'package:teta_core/src/design_system/text.dart';

class FlagControl extends StatefulWidget {
  const FlagControl({
    required this.title,
    required this.value,
    required this.callBack,
    Key? key,
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

  void _onSwitchChanged(bool value) {
    setState(() {
      switchOn = value;
    });
    widget.callBack(value, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(
          widget.title,
          color: Palette.white,
          size: 16,
          weight: FontWeight.bold,
        ),
        CSwitch(
          callback: _onSwitchChanged,
          value: switchOn,
        ),
      ],
    );
  }
}
