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

class WCmsCustomQuery extends StatefulWidget {
  /// Construct
  const WCmsCustomQuery(
    final Key? key, {
    required this.state,
    required this.query,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The from's value
  final FTextTypeInput query;

  /// The opzional child of this widget
  final List<CNode> children;

  @override
  _WCmsCustomQueryState createState() => _WCmsCustomQueryState();
}

class _WCmsCustomQueryState extends State<WCmsCustomQuery>
    with AfterLayoutMixin {
  DatasetObject _map = const DatasetObject(
    name: 'CMS Custom Query',
    map: [<String, dynamic>{}],
  );
  Future<TetaResponse<List<dynamic>?, TetaErrorResponse?>>? _future;

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    calc();
  }

  Future calc() async {
    final query = widget.query.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );

    if (query.isNotEmpty) {
      if (mounted) {
        setState(() {
          _future = TetaCMS.I.db.query(
            query,
          );
        });
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: widget.state,
      child: RepaintBoundary(
        child: FutureBuilder(
          future: _future,
          builder: (final context, final snapshot) {
            if (!snapshot.hasData) {
              if (widget.children.isNotEmpty) {
                return widget.children.last.toWidget(state: widget.state);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            if (snapshot.error != null) {
              // TODO: Returns a error widget
            }

            final list =
                (snapshot.data as TetaResponse?)?.data as List<dynamic>?;
            Logger.printWarning('list: $list');
            _map = _map.copyWith(
              name: widget.state.node.name ??
                  widget.state.node.intrinsicState.displayName,
              map: (list ?? const <dynamic>[])
                  .map(
                    (final dynamic e) =>
                        e as Map<String, dynamic>? ?? <String, dynamic>{},
                  )
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
          },
        ),
      ),
    );
  }
}
