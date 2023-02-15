// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCmsCount extends StatefulWidget {
  /// Construct
  const WCmsCount(
    final Key? key, {
    required this.state,
    required this.collection,
    required this.limit,
    required this.page,
    required this.keyName,
    required this.keyValue,
    required this.showDrafts,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The from's value
  final FTextTypeInput collection;
  final FTextTypeInput limit;
  final FTextTypeInput page;
  final FTextTypeInput keyValue;
  final FTextTypeInput keyName;
  final bool showDrafts;

  /// The optional child of this widget
  final List<CNode> children;

  @override
  _WCmsCountState createState() => _WCmsCountState();
}

class _WCmsCountState extends State<WCmsCount> with AfterLayoutMixin {
  DatasetObject _map = const DatasetObject(
    name: 'Collection Query',
    map: [<String, dynamic>{}],
  );
  late final Future<int>? _future;

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    calc();
  }

  Future calc() async {
    final collectionName = widget.collection.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final limit = widget.limit.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final page = widget.page.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final keyName = widget.keyName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final keyValue = widget.keyValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    if (mounted) {
      setState(() {
        _future = TetaCMS.instance.client.getCollectionCountByName(
          collectionName,
          filters: [
            if (keyName.isNotEmpty && keyValue.isNotEmpty)
              Filter(keyName, keyValue),
          ],
          limit: int.tryParse(limit) ?? 20,
          page: int.tryParse(page) ?? 0,
        );
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: RepaintBoundary(
        child: FutureBuilder<int>(
          future: _future,
          builder: (final context, final snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                if (widget.children.length > 1) {
                  return widget.children.last.toWidget(
                    state: widget.state,
                  );
                } else {
                  return const SizedBox();
                }
              }

              final count = snapshot.data ?? 0;
              _map = _map.copyWith(
                name: widget.state.node.name ??
                    widget.state.node.intrinsicState.displayName,
                map: [
                  <String, int>{
                    'count': count,
                  },
                ],
              );
              final datasets = addDataset(context, widget.state.dataset, _map);

              // Returns child
              if (widget.children.isNotEmpty) {
                return widget.children.first.toWidget(
                  state: widget.state.copyWith(
                    dataset: widget.state.dataset.isEmpty
                        ? datasets
                        : widget.state.dataset,
                  ),
                );
              } else {
                return const SizedBox();
              }
            } else {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
