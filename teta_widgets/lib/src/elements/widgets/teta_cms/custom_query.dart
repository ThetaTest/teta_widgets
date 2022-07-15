// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCmsCustomQuery extends StatefulWidget {
  /// Construct
  const WCmsCustomQuery(
    final Key? key, {
    required this.node,
    required this.query,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  /// The original CNode
  final CNode node;

  /// The from's value
  final FTextTypeInput query;

  /// The opzional child of this widget
  final List<CNode> children;

  /// Are we in Play Mode?
  final bool forPlay;

  /// The optional position inside a loop
  /// Widgets can be instantiate inside ListView.builder and other list widgets
  /// [loop] indicates the index position inside them
  final int? loop;

  /// The params of Scaffold
  final List<VariableObject> params;

  /// The states of Scaffold
  final List<VariableObject> states;

  /// The dataset list created by other widgets inside the same page
  final List<DatasetObject> dataset;

  @override
  _WCmsCustomQueryState createState() => _WCmsCustomQueryState();
}

class _WCmsCustomQueryState extends State<WCmsCustomQuery> {
  bool isInitialized = false;
  DatasetObject _map = DatasetObject(
    name: 'CMS Custom Query',
    map: [<String, dynamic>{}],
  );

  @override
  void initState() {
    calc();
    super.initState();
  }

  Future calc() async {
    final query = widget.query.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );

    if (query.isNotEmpty) {
        final response = await TetaCMS.instance.client.query(
          query,
        );

        Logger.printWarning('list: ${response.data}');

      setState(() {
        _addFetchDataToDataset(response.data);
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    Widget? child;
    if(isInitialized) {
      if (widget.children.isNotEmpty) {
        child = widget.children.first.toWidget(
          params: widget.params,
          states: widget.states,
          dataset: widget.dataset,
          forPlay: widget.forPlay,
        );
      } else {
        child = const SizedBox();
      }
    }

    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: RepaintBoundary(
        child: child,
      ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final List<dynamic>? list) {
    _map = _map.copyWith(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: (list ?? const <dynamic>[])
          .map(
            (final dynamic e) =>
        e as Map<String, dynamic>? ?? <String, dynamic>{},
      )
          .toList(),
    );

    final datasets = addDataset(context, widget.dataset, _map);

    return widget.dataset.isEmpty ? datasets : widget.dataset;
  }
}
