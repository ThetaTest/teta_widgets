// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:theta_models/theta_models.dart';

class WGridViewBuilder extends StatefulWidget {
  /// Returns a StaggeredGridView (children: [ ]) in Teta
  const WGridViewBuilder(
    final Key? key, {
    required this.state,
    required this.value,
    required this.startFromIndex,
    required this.limit,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.isVertical,
    required this.primary,
    required this.shrinkWrap,
    required this.childAspectRatio,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FDataset value;
  final bool isVertical;
  final bool primary;
  final bool shrinkWrap;
  final FTextTypeInput startFromIndex;
  final FTextTypeInput limit;
  final FTextTypeInput crossAxisCount;
  final FTextTypeInput mainAxisSpacing;
  final FTextTypeInput crossAxisSpacing;
  final FTextTypeInput childAspectRatio;

  @override
  State<WGridViewBuilder> createState() => _WGridViewState();
}

class _WGridViewState extends State<WGridViewBuilder> {
  DatasetObject map = DatasetObject.empty();
  bool isLoading = true;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: _body(context),
    );
  }

  /// Returns a MouseRegion to disable the zoom on editor screen
  /// and provides a StaggeredGridView
  Widget _body(final BuildContext context) {
    final crossAxisCountString = widget.crossAxisCount.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final mainAxisSpacingString = widget.mainAxisSpacing.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final crossAxisSpacingString = widget.crossAxisSpacing.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final childAspectRatioString = widget.childAspectRatio.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    _setDataset();
    final index = widget.value.datasetName != null
        ? widget.state.dataset.indexWhere(
            (final element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db =
        index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
    var startFromIndex = int.tryParse(
          widget.startFromIndex.get(
            widget.state.params,
            widget.state.states,
            widget.state.dataset,
            widget.state.forPlay,
            widget.state.loop,
            context,
          ),
        ) ??
        0;
    if (startFromIndex < 0) {
      startFromIndex = 0;
    }
    if (startFromIndex >= db.getMap.length) {
      startFromIndex = 0;
    }
    var limit = int.tryParse(
          widget.limit.get(
            widget.state.params,
            widget.state.states,
            widget.state.dataset,
            widget.state.forPlay,
            widget.state.loop,
            context,
          ),
        ) ??
        db.getMap.length;
    if (limit <= 0) {
      limit = db.getMap.length;
    }
    if (limit > db.getMap.length) {
      limit = db.getMap.length;
    }
    return GridView.builder(
      shrinkWrap: widget.shrinkWrap,
      primary: widget.primary,
      scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
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
      itemCount: db.getMap.sublist(startFromIndex, limit).length,
      itemBuilder: (final context, final index) => widget.child != null
          ? widget.child!.toWidget(
              state: widget.state.copyWith(
                params: [...widget.state.params, ...widget.state.params],
                loop: index,
              ),
            )
          : PlaceholderChildBuilder(
              name: widget.state.node.intrinsicState.displayName,
              node: widget.state.node,
              forPlay: widget.state.forPlay,
            ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.state.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db =
          index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
      if (mounted) {
        if (db.getName != '') {
          setState(() {
            map = db;
          });
        }
      }
    } catch (_) {}
  }
}
