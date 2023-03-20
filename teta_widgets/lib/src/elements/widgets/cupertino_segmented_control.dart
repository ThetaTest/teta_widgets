//CupertinoSegmentedControl

// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class WCupertinoSegmentedControl extends StatefulWidget {
  /// Returns a Gesture Detector
  const WCupertinoSegmentedControl(
    final Key? key, {
    required this.state,
    required this.children,
    required this.pressedColor,
    required this.selectedColor,
    required this.unselectedColor,
    required this.borderColor,
    //required this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  //final FAction action;
  final FFill pressedColor;
  final FFill selectedColor;
  final FFill unselectedColor;
  final FFill borderColor;

  @override
  State<WCupertinoSegmentedControl> createState() =>
      _WCupertinoSegmentedControlState();
}

class _WCupertinoSegmentedControlState
    extends State<WCupertinoSegmentedControl> {
  int value = 0;
  @override
  Widget build(final BuildContext context) {
    final map = <int, Widget>{};
    for (var i = 0; i < widget.children.length; i++) {
      map[i] = widget.children[i].toWidget(state: widget.state);
    }
    if (map.keys.isEmpty) {
      map[0] = Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: const Center(
          child: THeadline3(
            'Option 1',
          ),
        ),
      );
      map[1] = Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: const Center(
          child: THeadline3(
            'Option 2',
          ),
        ),
      );
    }
    return NodeSelectionBuilder(
      state: widget.state,
      child: IgnorePointer(
        ignoring: !widget.state.forPlay,
        child: CupertinoSegmentedControl<int>(
          children: map,
          groupValue: value,
          pressedColor: HexColor(widget.pressedColor.getHexColor(context)),
          selectedColor: HexColor(widget.selectedColor.getHexColor(context)),
          unselectedColor:
              HexColor(widget.unselectedColor.getHexColor(context)),
          borderColor: HexColor(widget.borderColor.getHexColor(context)),
          onValueChanged: (final v) {
            GestureBuilder.get(
              context: context,
              state: widget.state,
              action: null, //widget.action,
              actionValue: null, //FTextTypeInput(value: '$v'),
              gesture: ActionGesture.onTap,
            );
            setState(() {
              value = v;
            });
          },
        ),
      ),
    );
  }
}
