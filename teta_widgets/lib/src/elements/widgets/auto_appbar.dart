// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WAutoAppBar extends StatelessWidget {
  /// Constructor
  const WAutoAppBar(
    final Key? key, {
    required this.value,
    required this.style,
    required this.fill,
    required this.children,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.loop,
  }) : super(key: key);

  final FTextTypeInput value;
  final FTextStyle style;
  final FFill fill;
  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    final childrenWidgets = children.isNotEmpty
        ? children
            .map(
              (final e) => e.toWidget(
                loop: loop,
                forPlay: forPlay,
                params: params,
                states: states,
                dataset: dataset,
              ),
            )
            .toList()
        : [
            PlaceholderChildBuilder(
              name: node.intrinsicState.displayName,
              node: node,
              forPlay: forPlay,
            ),
          ];
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
        child: TContainer(
          width: double.maxFinite,
          padding: EI.mdA,
          decoration: TetaBoxDecoration.get(
            context: context,
            fill: fill.get(context),
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (Navigator.canPop(context))
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: HexColor(style.fill!.getHexColor(context)),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          if (!Scaffold.of(context).isDrawerOpen) {
                            Scaffold.of(context).openDrawer();
                          }
                        },
                        child: Icon(
                          Icons.menu,
                          color: HexColor(style.fill!.getHexColor(context)),
                        ),
                      ),
                    const Gap(Grid.small),
                    WText(
                      this.key,
                      value: value,
                      node: node,
                      textStyle: style,
                      forPlay: forPlay,
                      isFullWidth: false,
                      params: params,
                      states: states,
                      dataset: dataset,
                      maxLines: FTextTypeInput(value: '1'),
                    ),
                  ],
                ),
                ...childrenWidgets,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
