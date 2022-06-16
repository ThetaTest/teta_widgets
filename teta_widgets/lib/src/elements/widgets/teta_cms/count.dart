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

class WCmsCount extends StatefulWidget {
  /// Construct
  const WCmsCount(
    final Key? key, {
    required this.node,
    required this.collection,
    required this.limit,
    required this.page,
    required this.keyName,
    required this.keyValue,
    required this.showDrafts,
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
  final FTextTypeInput collection;
  final FTextTypeInput limit;
  final FTextTypeInput page;
  final FTextTypeInput keyValue;
  final FTextTypeInput keyName;
  final bool showDrafts;

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
  _WCmsCountState createState() => _WCmsCountState();
}

class _WCmsCountState extends State<WCmsCount> {
  DatasetObject _map = DatasetObject(
    name: 'Collection Query',
    map: [<String, dynamic>{}],
  );
  late final Future<int>? _future;

  @override
  void initState() {
    super.initState();
    calc();
  }

  Future calc() async {
    final collectionId = widget.collection.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final limit = widget.limit.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final page = widget.page.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final keyName = widget.keyName.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final keyValue = widget.keyValue.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    setState(() {
      _future = TetaCMS.instance.client.getCollectionCount(
        collectionId,
        filters: [
          if (keyName.isNotEmpty && keyValue.isNotEmpty)
            Filter(keyName, keyValue),
        ],
        limit: int.tryParse(limit) ?? 20,
        page: int.tryParse(page) ?? 0,
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: FutureBuilder<int>(
        future: _future,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                forPlay: widget.forPlay,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          if (snapshot.error != null) {
            // TODO: Returns a error widget
          }

          final count = snapshot.data ?? 0;
          _map = _map.copyWith(
            name: widget.node.name ?? widget.node.intrinsicState.displayName,
            map: [
              <String, int>{
                'count': count,
              },
            ],
          );
          final datasets = addDataset(context, widget.dataset, _map);

          // Returns child
          if (widget.children.isNotEmpty) {
            return widget.children.first.toWidget(
              params: widget.params,
              states: widget.states,
              dataset: widget.dataset.isEmpty ? datasets : widget.dataset,
              forPlay: widget.forPlay,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
