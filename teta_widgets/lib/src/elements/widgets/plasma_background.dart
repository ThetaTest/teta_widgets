// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:sa3_liquid/liquid/plasma/plasma.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WPlasmaBackground extends StatefulWidget {
  const WPlasmaBackground(
    final Key? key, {
    required this.node,
    required this.width,
    required this.height,
    required this.firstColor,
    required this.secondColor,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FSize width;
  final FSize height;
  final FFill firstColor;
  final FFill secondColor;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  WPlasmaBackgroundState createState() => WPlasmaBackgroundState();
}

class WPlasmaBackgroundState extends State<WPlasmaBackground> {
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: Container(
        width: widget.width.get(context: context, isWidth: true),
        height: widget.height.get(context: context, isWidth: false),
        color: Colors.black,
        child: body(context),
      ),
    );
  }

  Widget body(final BuildContext context) {
    return PlasmaRenderer(
      fps: 50,
      color: HexColor(widget.firstColor.levels!.first.color),
      blur: 0.36,
      size: 1.33,
      speed: 5.75,
      child: PlasmaRenderer(
        fps: 50,
        color: HexColor(widget.secondColor.levels!.first.color),
        blur: 0.79,
        size: 0.87,
        offset: 2,
        blendMode: BlendMode.overlay,
        child: widget.child != null
            ? widget.child!.toWidget(
                forPlay: widget.forPlay,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
              )
            : const SizedBox(),
      ),
    );
  }
}
