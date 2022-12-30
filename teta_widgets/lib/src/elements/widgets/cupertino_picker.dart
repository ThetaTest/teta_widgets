// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WCupertinoPicker extends StatefulWidget {
  /// Returns a Gesture Detector
  const WCupertinoPicker(
    final Key? key, {
    required this.state,
    required this.children,
    required this.height,
    required this.loopingFlag,
    required this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FAction action;
  final FSize height;
  final bool loopingFlag;

  @override
  State<WCupertinoPicker> createState() => _WCupertinoPickerState();
}

class _WCupertinoPickerState extends State<WCupertinoPicker> {
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: CupertinoPicker(
        itemExtent: widget.height.get(context: context, isWidth: false) ?? 44,
        onSelectedItemChanged: (final index) {
          GestureBuilder.get(
            context: context,
            state: widget.state,
            action: widget.action,
            actionValue: null,
            gesture: ActionGesture.onChange,
          );
        },
        looping: widget.loopingFlag,
        children: widget.children
            .map(
              (final e) => e.toWidget(state: widget.state),
            )
            .toList(),
      ),
    );
  }
}
