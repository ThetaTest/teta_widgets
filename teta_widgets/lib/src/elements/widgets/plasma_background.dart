// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:sa3_liquid/liquid/plasma/plasma.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WPlasmaBackground extends StatefulWidget {
  const WPlasmaBackground(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    required this.firstColor,
    required this.secondColor,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize width;
  final FSize height;
  final FFill firstColor;
  final FFill secondColor;

  @override
  WPlasmaBackgroundState createState() => WPlasmaBackgroundState();
}

class WPlasmaBackgroundState extends State<WPlasmaBackground> {
  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: Container(
        width: widget.width.get(context: context, isWidth: true),
        height: widget.height.get(context: context, isWidth: false),
        color: Colors.black,
        child: PlasmaRenderer(
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
                ? widget.child!.toWidget(state: widget.state)
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
