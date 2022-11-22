// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WPageView extends StatefulWidget {
  /// Returns a PageViewwidget
  const WPageView(
    final Key? key, {
    required this.state,
    required this.children,
    required this.isVertical,
    required this.flagValue,
    required this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final bool isVertical;
  final bool flagValue;
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
    return TetaWidget(
      state: widget.state,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 850),
        child: PageView.builder(
          controller: controller,
          scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
          onPageChanged: (final i) => GestureBuilder.get(
            context: context,
            node: widget.state.node,
            gesture: ActionGesture.onChange,
            action: widget.action,
            actionValue: FTextTypeInput(value: '$i'),
            params: widget.state.params,
            states: widget.state.states,
            dataset: widget.state.dataset,
            forPlay: widget.state.forPlay,
            loop: widget.state.loop,
          ),
          itemCount: widget.children.length,
          itemBuilder: (final context, final index) => widget.children.isNotEmpty
              ? widget.children
                  .map(
                    (final e) => e.toWidget(state: widget.state),
                  )
                  .toList()[index]
              : [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: THeadline3(
                        'PageView - Page 1',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: THeadline3(
                        'PageView - Page 2',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: THeadline3(
                        'PageView - Page 3',
                      ),
                    ),
                  ),
                ][index],
        ),
      ),
    );
  }
}
