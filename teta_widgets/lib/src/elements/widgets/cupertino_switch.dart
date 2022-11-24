// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WCupertinoSwitch extends StatefulWidget {
  /// Returns a Gesture Detector
  const WCupertinoSwitch(
    final Key? key, {
    required this.state,
    required this.action,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAction action;

  @override
  State<WCupertinoSwitch> createState() => _WCupertinoSwitchState();
}

class _WCupertinoSwitchState extends State<WCupertinoSwitch> {
  bool flag = false;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.state.node,
      forPlay: widget.state.forPlay,
      child: CupertinoSwitch(
        onChanged: (final value) {
          GestureBuilder.get(
            context: context,
            node: widget.state.node,
            action: widget.action,
            actionValue: null,
            gesture: ActionGesture.onTap,
            params: widget.state.params,
            states: widget.state.states,
            dataset: widget.state.dataset,
            forPlay: widget.state.forPlay,
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
