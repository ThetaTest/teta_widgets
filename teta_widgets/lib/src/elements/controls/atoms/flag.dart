// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';

class FlagControl extends StatefulWidget {
  const FlagControl({
    required this.title,
    required this.value,
    required this.node,
    required this.keyValue,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String title;
  final bool value;
  final NDynamic node;
  final String? keyValue;
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
    if (widget.keyValue != null) {
      widget.node.body.attributes[widget.keyValue!] = value;
    }
    widget.callBack(value, widget.value);
  }

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        THeadline3(
          widget.title,
        ),
        CSwitch(
          callback: _onSwitchChanged,
          value: switchOn,
        ),
      ],
    );
  }
}
