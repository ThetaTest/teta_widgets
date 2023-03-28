// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class WAutoAppBar extends StatelessWidget {
  /// Constructor
  const WAutoAppBar(
    final Key? key, {
    required this.state,
    required this.value,
    required this.style,
    required this.fill,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput value;
  final FTextStyle style;
  final FFill fill;
  final List<CNode> children;

  @override
  Widget build(final BuildContext context) {
    final childrenWidgets = children.isNotEmpty
        ? children
            .map(
              (final e) => e.toWidget(state: state),
            )
            .toList()
        : [
            PlaceholderChildBuilder(
              name: state.node.intrinsicState.displayName,
              node: state.node,
              forPlay: state.forPlay,
            ),
          ];
    return TetaWidget(
      state: state,
      child: TContainer(
        width: double.maxFinite,
        padding: EI.mdA,
        decoration: TetaBoxDecoration.get(
          context: context,
          forPlay: state.forPlay,
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
                    state: state,
                    textStyle: style,
                    isFullWidth: false,
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
