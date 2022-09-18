// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WCupertinoSwitch extends StatefulWidget {
  /// Returns a Gesture Detector
  const WCupertinoSwitch(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.action,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FAction action;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WCupertinoSwitch> createState() => _WCupertinoSwitchState();
}

class _WCupertinoSwitchState extends State<WCupertinoSwitch> {
  bool flag = false;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: CupertinoSwitch(
        onChanged: (final value) {
          GestureBuilder.get(
            context: context,
            node: widget.node,
            action: widget.action,
            actionValue: null,
            gesture: ActionGesture.onTap,
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
          );
          if (mounted) {
            setState(() {
              flag = value;
            });
          }
        },
        value: flag,
      ),
    );
  }
}
