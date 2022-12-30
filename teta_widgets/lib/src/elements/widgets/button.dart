// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

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
  final FAction action;
  final FTextTypeInput actionValue;
  final FPageTransition pageTransition;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: state,
      child: IgnorePointer(
        ignoring: !state.forPlay,
        child: GestureDetector(
          onTap: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onTap,
            action: action,
            actionValue: null,
          ),
          onDoubleTap: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onDoubleTap,
            action: action,
            actionValue: null,
          ),
          onLongPress: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onLongPress,
            action: action,
            actionValue: null,
          ),
          child: GestureBuilderBase.get(
            context: context,
            state: state,
            child: SizedBox(
              width: width.get(context: context, isWidth: true),
              height: height.get(context: context, isWidth: false),
              child: DecoratedBox(
                decoration: TetaBoxDecoration.get(
                  context: context,
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
