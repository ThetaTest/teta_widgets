// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:supabase/supabase.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:theta_models/theta_models.dart';

// ignore_for_file: public_member_api_docs

class WCmsStream extends StatefulWidget {
  /// Construct
  const WCmsStream(
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
  _WCmsStreamState createState() => _WCmsStreamState();
}

class _WCmsStreamState extends State<WCmsStream> with AfterLayoutMixin {
  DatasetObject _map = const DatasetObject(
    name: 'Collection Stream',
    map: [<String, dynamic>{}],
  );
  bool isLoaded = true;
  late final StreamController<List<dynamic>> _stream;
  SupabaseClient? client;

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
    Logger.printWarning(
      '$collectionName, keyName: $keyName, keyValue: $keyValue, limit: $limit, page: $page ',
    );
    if (mounted) {
      setState(() {
        _stream = TetaCMS.I.db.from('collectionName').stream(
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
      state: widget.state,
      child: RepaintBoundary(
        child: StreamBuilder(
          stream: _stream.stream,
          builder: (final context, final snapshot) {
            if (!snapshot.hasData ||
                ((snapshot.data as List<dynamic>?)?.isEmpty ?? false)) {
              if (widget.children.isNotEmpty) {
                return widget.children.last.toWidget(state: widget.state);
              } else {
                return const SizedBox();
              }
            } else {
              final list = snapshot.data as List<dynamic>?;
              _map = _map.copyWith(
                name: widget.state.node.name ??
                    widget.state.node.intrinsicState.displayName,
                map: (list ?? const <dynamic>[])
                    .map((final dynamic e) => e as Map<String, dynamic>)
                    .toList(),
              );
              final datasets = addDataset(context, _map);

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
            }
          },
        ),
      ),
    );
  }
}
