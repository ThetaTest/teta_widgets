// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WListViewBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WListViewBuilder({
    Key? key,
    this.nid,
    required this.child,
    required this.node,
    required this.forPlay,
    required this.value,
    this.loop,
    required this.shrinkWrap,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final CNode? child;
  final bool forPlay;
  final bool shrinkWrap;
  final bool isVertical;
  final FDataset value;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  WListViewBuilderState createState() => WListViewBuilderState();
}

class WListViewBuilderState extends State<WListViewBuilder> {
  DatasetObject map = DatasetObject.empty;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    _setDataset();
    final index = widget.value.datasetName != null
        ? widget.dataset.indexWhere(
            (element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db = index != -1 ? widget.dataset[index] : DatasetObject.empty;
    return ListView.builder(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
      itemCount: db.getMap.length,
      itemBuilder: (context, index) => widget.child != null
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
    );
  }

  void _setDataset() {
    try {
      final index = widget.dataset
          .indexWhere((element) => element.getName == widget.value.datasetName);
      final db = index != -1 ? widget.dataset[index] : DatasetObject.empty;
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
