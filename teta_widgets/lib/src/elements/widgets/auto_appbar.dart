// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WAutoAppBar extends StatelessWidget {
  /// Constructor
  const WAutoAppBar(
    final Key? key, {
    required final this.value,
    required final this.style,
    required final this.fill,
    required final this.children,
    required final this.node,
    required final this.forPlay,
    required final this.params,
    required final this.states,
    required final this.dataset,
    required final this.loop,
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
    );
  }
}
