// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WListViewBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WListViewBuilder(
    final Key? key, {
    required this.child,
    required this.node,
    required this.forPlay,
    required this.value,
    required this.shrinkWrap,
    required this.isVertical,
    required this.isReverse,
    required this.physic,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final bool shrinkWrap;
  final bool isVertical;
  final bool isReverse;
  final FDataset value;
  final FPhysic physic;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  WListViewBuilderState createState() => WListViewBuilderState();
}

class WListViewBuilderState extends State<WListViewBuilder> {
  DatasetObject map = DatasetObject.empty();
  bool isLoading = true;

  @override
  Widget build(final BuildContext context) {
    _setDataset();
    final index = widget.value.datasetName != null
        ? widget.dataset.indexWhere(
            (final element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db = index != -1 ? widget.dataset[index] : DatasetObject.empty();
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: ListView.builder(
        reverse: widget.isReverse,
        physics: widget.physic.physics,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: db.getMap.length,
        itemBuilder: (final context, final index) => widget.child != null
            ? widget.child!.toWidget(
                forPlay: widget.forPlay,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                loop: index,
              )
            : PlaceholderChildBuilder(
                name: widget.node.intrinsicState.displayName,
              ),
      ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db = index != -1 ? widget.dataset[index] : DatasetObject.empty();
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
