// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WPageView extends StatefulWidget {
  /// Returns a PageViewwidget
  const WPageView(
    final Key? key, {
    required this.children,
    required this.isVertical,
    required this.flagValue,
    required this.node,
    required this.action,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool isVertical;
  final bool flagValue;
  final bool forPlay;
  final int? loop;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;
  final FAction action;

  @override
  _WPageViewState createState() => _WPageViewState();
}

class _WPageViewState extends State<WPageView> {
  PageController? controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: body(context),
    );
  }

  Widget body(final BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 850),
      child: PageView(
        controller: controller,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        onPageChanged: (final i) => GestureBuilder.get(
          context: context,
          node: widget.node,
          gesture: ActionGesture.onChange,
          action: widget.action,
          actionValue: FTextTypeInput(value: '$i'),
          params: widget.params,
          states: widget.states,
          dataset: widget.dataset,
          forPlay: widget.forPlay,
          loop: widget.loop,
        ),
        children: widget.children.isNotEmpty
            ? widget.children
                .map(
                  (final e) => e.toWidget(
                    loop: widget.children.indexOf(e),
                    forPlay: widget.forPlay,
                    params: widget.params,
                    states: widget.states,
                    dataset: widget.dataset,
                  ),
                )
                .toList()
            : [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CText(
                      'PageView - Page 1',
                      typography: Headline3(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CText(
                      'PageView - Page 2',
                      typography: Headline3(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CText(
                      'PageView - Page 3',
                      typography: Headline3(),
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}
