// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WGridView extends StatelessWidget {
  /// Returns a StaggeredGridView (children: [ ]) in Teta
  const WGridView(
    final Key? key, {
    required this.state,
    required this.children,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.isVertical,
    required this.isPrimary,
    required this.childAspectRatio,
    required this.shrinkWrap,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;

  final bool isVertical;
  final bool isPrimary;
  final bool shrinkWrap;
  final FTextTypeInput crossAxisCount;
  final FTextTypeInput mainAxisSpacing;
  final FTextTypeInput crossAxisSpacing;
  final FTextTypeInput childAspectRatio;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(state: state, child: _body(context));
  }

  /// Returns a MouseRegion to disable the zoom on editor screen
  /// and provides a StaggeredGridView
  Widget _body(final BuildContext context) {
    final crossAxisCountString = crossAxisCount.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final mainAxisSpacingString = mainAxisSpacing.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final crossAxisSpacingString = crossAxisSpacing.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final childAspectRatioString = childAspectRatio.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: int.tryParse(crossAxisCountString) != null &&
                (int.tryParse(crossAxisCountString) ?? 0) > 0.1
            ? int.parse(crossAxisCountString)
            : 2,
        mainAxisSpacing: double.tryParse(mainAxisSpacingString) != null &&
                (double.tryParse(mainAxisSpacingString) ?? 0) > 0.1
            ? double.parse(mainAxisSpacingString)
            : 2,
        crossAxisSpacing: double.tryParse(crossAxisSpacingString) != null &&
                (double.tryParse(crossAxisSpacingString) ?? 0) > 0.1
            ? double.parse(crossAxisSpacingString)
            : 2,
        childAspectRatio: double.tryParse(childAspectRatioString) != null &&
                (double.tryParse(childAspectRatioString) ?? 0) > 0.1
            ? double.parse(childAspectRatioString)
            : 1,
      ),
      shrinkWrap: shrinkWrap,
      primary: isPrimary,
      scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
      itemCount: children.isEmpty ? 1 : children.length,
      itemBuilder: (final context, final index) => children.isNotEmpty
          ? children[index].toWidget(
              state: state.copyWith(loop: index),
            )
          : PlaceholderChildBuilder(
              name: state.node.intrinsicState.displayName,
              node: state.node,
              forPlay: state.forPlay,
            ),
    );
  }
}
