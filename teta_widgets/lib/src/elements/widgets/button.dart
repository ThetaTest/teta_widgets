// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import '../../core/teta_widget/index.dart';
import '../builder/gesture_detector_base.dart';
// Project imports:
import '../index.dart';

// ignore_for_file: public_member_api_docs

class WButton extends StatelessWidget {
  /// Returns a Button widget in Teta
  const WButton(
    final Key? key, {
    required this.state,
    required this.value,
    required this.width,
    required this.height,
    required this.fill,
    required this.textStyle,
    required this.borderRadius,
    required this.textAlignPosition,
    required this.action,
    required this.actionValue,
    required this.pageTransition,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput value;
  final FSize width;
  final FSize height;
  final FFill fill;
  final FBorderRadius borderRadius;
  final FTextStyle textStyle;
  final FAlign textAlignPosition;
  final NodeGestureActions action;
  final FTextTypeInput actionValue;
  final FPageTransition pageTransition;

  @override
  Widget build(final BuildContext context) {
    return GestureBuilderBase.get(
      context: context,
      state: state,
      child: NodeSelectionBuilder(
        state: state,
        child: IgnorePointer(
          ignoring: !state.forPlay,
          child: GestureDetector(
            onTap: () => GestureBuilder.get(
              context: context,
              state: state,
              gesture: ActionGesture.onTap,
              nodeGestureActions: action,
              actionValue: null,
            ),
            onDoubleTap: () => GestureBuilder.get(
              context: context,
              state: state,
              gesture: ActionGesture.onDoubleTap,
              nodeGestureActions: action,
              actionValue: null,
            ),
            onLongPress: () => GestureBuilder.get(
              context: context,
              state: state,
              gesture: ActionGesture.onLongPress,
              nodeGestureActions: action,
              actionValue: null,
            ),
            child: SizedBox(
              width: width.get(
                context: context,
                isWidth: true,
                forPlay: state.forPlay,
              ),
              height: height.get(
                context: context,
                isWidth: false,
                forPlay: state.forPlay,
              ),
              child: DecoratedBox(
                decoration: TetaBoxDecoration.get(
                  context: context,
                  forPlay: state.forPlay,
                  fill: fill.get(context),
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextBuilder(
                      textStyle: textStyle,
                      value: value,
                      params: state.params,
                      states: state.states,
                      dataset: state.dataset,
                      forPlay: state.forPlay,
                      loop: state.loop,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
