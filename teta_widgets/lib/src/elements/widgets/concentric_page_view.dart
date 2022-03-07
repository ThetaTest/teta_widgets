// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:concentric_transition/concentric_transition.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WConcentricPageView extends StatefulWidget {
  /// Returns a PageViewwidget
  const WConcentricPageView(
    Key? key, {
    required this.children,
    required this.fill,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final FFill fill;
  final bool forPlay;
  final int? loop;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  _WConcentricPageViewState createState() => _WConcentricPageViewState();
}

class _WConcentricPageViewState extends State<WConcentricPageView> {
  PageController? controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: ConcentricPageView(
        colors: widget.children.length >= 2
            ? widget.children
                .map(
                  (e) => HexColor(widget.fill.getHexColor(context)),
                )
                .toList()
            : [
                HexColor(widget.fill.getHexColor(context)),
                HexColor(widget.fill.getHexColor(context))
              ],
        itemCount: widget.children.length,
        itemBuilder: (int index, double value) {
          return widget.children[index].toWidget(
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
          );
        },
      ),
    );
  }
}
