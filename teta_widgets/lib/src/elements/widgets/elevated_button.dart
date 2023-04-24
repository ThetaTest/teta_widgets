import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

import '../../core/teta_widget/index.dart';
import '../index.dart';

class WElevatedButton extends StatelessWidget {
  /// Returns a ElevatedButton widget in Teta
  const WElevatedButton(
    final Key? key, {
    required this.state,
    required this.child,
    required this.action,
    required this.actionValue,
    required this.width,
    required this.height,
    required this.fill,
    required this.value,
    required this.borderRadius,

  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAction? action;
  final FTextTypeInput actionValue;
  final FSize width;
  final FSize height;
  final FFill fill;
  final FBorderRadius borderRadius;
  final FTextTypeInput value;



  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: SizedBox(
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor(fill.getHexColor(context)),
),
          onLongPress: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onLongPress,
            actionValue: null,
            action: action,
          ),
          onHover: (value)=> GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onHover,
            actionValue: null,
            action: action,
          ),
          onPressed: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onTap,
            actionValue: null,
            action: action,
          ),
          child: ChildConditionBuilder(
            ValueKey(state.toKey),
            state: state,
            child: child,
          ),
        ),
      ),
    );
  }
}
