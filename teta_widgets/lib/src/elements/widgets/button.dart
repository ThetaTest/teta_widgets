// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// ignore_for_file: public_member_api_docs

class WButton extends StatelessWidget {
  /// Returns a Button widget in Teta
  const WButton(
    Key? key, {
    required this.value,
    required this.node,
    required this.width,
    required this.height,
    required this.fill,
    required this.textStyle,
    required this.borderRadius,
    required this.forPlay,
    required this.textAlignPosition,
    required this.action,
    required this.actionValue,
    required this.pageTransition,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final FSize width;
  final FSize height;
  final FFill fill;
  final FBorderRadius borderRadius;
  final FTextStyle textStyle;
  final bool forPlay;
  final FAlign textAlignPosition;
  final FAction action;
  final FTextTypeInput actionValue;
  final FPageTransition pageTransition;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: GestureDetector(
        onTap: () => GestureBuilder.get(
          context: context,
          node: node,
          gesture: ActionGesture.onTap,
          action: action,
          actionValue: actionValue,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
        ),
        onDoubleTap: () => GestureBuilder.get(
          context: context,
          node: node,
          gesture: ActionGesture.onDoubleTap,
          action: action,
          actionValue: actionValue,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
        ),
        onLongPress: () => GestureBuilder.get(
          context: context,
          node: node,
          gesture: ActionGesture.onLongPress,
          action: action,
          actionValue: actionValue,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
        ),
        child: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    return SizedBox(
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
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
            ),
          ),
        ),
      ),
    );
  }
}
