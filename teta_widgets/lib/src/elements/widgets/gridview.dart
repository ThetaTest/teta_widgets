// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WGridView extends StatelessWidget {
  /// Returns a StaggeredGridView (children: [ ]) in Teta
  const WGridView(
    Key? key, {
    required this.children,
    required this.node,
    required this.forPlay,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
    required this.isPrimary,
    required this.childAspectRatio,
    required this.shrinkWrap,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;

  final bool isVertical;
  final bool isPrimary;
  final bool shrinkWrap;
  final FTextTypeInput crossAxisCount;
  final FTextTypeInput mainAxisSpacing;
  final FTextTypeInput crossAxisSpacing;
  final FTextTypeInput childAspectRatio;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: _body(context),
    );
  }

  /// Returns a MouseRegion to disable the zoom on editor screen
  /// and provides a StaggeredGridView
  Widget _body(BuildContext context) {
    final crossAxisCountString =
        crossAxisCount.get(params, states, dataset, forPlay, loop);
    final mainAxisSpacingString =
        mainAxisSpacing.get(params, states, dataset, forPlay, loop);
    final crossAxisSpacingString =
        crossAxisSpacing.get(params, states, dataset, forPlay, loop);
    final childAspectRatioString =
        childAspectRatio.get(params, states, dataset, forPlay, loop);
    return MouseRegion(
      onEnter: (v) {
        BlocProvider.of<ZoomableCubit>(context)
            .changeZoomableFlag(value: false);
      },
      onExit: (v) {
        BlocProvider.of<ZoomableCubit>(context).changeZoomableFlag(value: true);
      },
      child: GridView.builder(
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
        itemBuilder: (context, index) => children.isNotEmpty
            ? children[index].toWidget(
                loop: index,
                forPlay: forPlay,
                params: params,
                states: states,
                dataset: dataset,
              )
            : PlaceholderChildBuilder(name: node.intrinsicState.displayName),
      ),
    );
  }
}
