// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';
// Package imports:
import 'package:supabase/supabase.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCmsStream extends StatefulWidget {
  /// Construct
  const WCmsStream(
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
  _WCmsStreamState createState() => _WCmsStreamState();
}

class _WCmsStreamState extends State<WCmsStream> {
  DatasetObject _map = DatasetObject(
    name: 'Collection Stream',
    map: [<String, dynamic>{}],
  );
  bool isLoaded = true;
  late final StreamController<List<dynamic>> _stream;
  SupabaseClient? client;

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
      context,
    );
    final limit = widget.limit.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    final page = widget.page.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    final keyName = widget.keyName.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    final keyValue = widget.keyValue.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    Logger.printWarning(
      '$collectionId, keyName: $keyName, keyValue: $keyValue, limit: $limit, page: $page ',
    );
    if (mounted) {
      setState(() {
        _stream = TetaCMS.instance.realtime.streamCollection(
          collectionId,
          filters: [
            if (keyName.isNotEmpty && keyValue.isNotEmpty)
              Filter(keyName, keyValue),
          ],
          limit: int.tryParse(limit) ?? 20,
          page: int.tryParse(page) ?? 0,
          showDrafts: widget.showDrafts,
        );
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: RepaintBoundary(
        child: StreamBuilder(
          stream: _stream.stream,
          builder: (final context, final snapshot) {
            if (!snapshot.hasData ||
                ((snapshot.data as List<dynamic>?)?.isEmpty ?? false)) {
              if (widget.children.isNotEmpty) {
                return widget.children.last.toWidget(
                  params: widget.params,
                  states: widget.states,
                  dataset: widget.dataset,
                  forPlay: widget.forPlay,
                );
              } else {
                return const SizedBox();
              }
            } else {
              final list = snapshot.data as List<dynamic>?;
              _map = _map.copyWith(
                name:
                    widget.node.name ?? widget.node.intrinsicState.displayName,
                map: (list ?? const <dynamic>[])
                    .map((final dynamic e) => e as Map<String, dynamic>)
                    .toList(),
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
            }
          },
        ),
      ),
    );
  }
}
