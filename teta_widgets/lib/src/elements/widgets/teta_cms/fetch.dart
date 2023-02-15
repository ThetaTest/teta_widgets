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

class WCmsFetch extends StatefulWidget {
  /// Construct
  const WCmsFetch(
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

  /// The opzional child of this widget
  final List<CNode> children;

  @override
  _WCmsFetchState createState() => _WCmsFetchState();
}

class _WCmsFetchState extends State<WCmsFetch> with AfterLayoutMixin {
  String? collectionName;
  bool isInitialized = false;
  List<dynamic> list = <dynamic>[];
  DatasetObject _map = const DatasetObject(
    name: 'Collection Query',
    map: [<String, dynamic>{}],
  );

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    getDbElements();
  }

  Future<void> getDbElements() async {
    collectionName = widget.collection.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    if (collectionName == '') return;
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
    final res = await TetaCMS.instance.client.getCollectionByName(
      collectionName!,
      filters: [
        if (keyName.isNotEmpty && keyValue.isNotEmpty)
          Filter(keyName, keyValue),
      ],
      limit: int.tryParse(limit) ?? 20,
      page: int.tryParse(page) ?? 0,
      showDrafts: widget.showDrafts,
    );
    if (res.error != null) return;

    if (mounted) {
      setState(() {
        list = res.data!;
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: Builder(
        builder: (final context) {
          if (collectionName == null ||
              collectionName == '' ||
              widget.children.isEmpty) {
            return Center(
              child: ChildConditionBuilder(
                ValueKey(widget.state.toKey),
                state: widget.state,
                child: null,
              ),
            );
          }

          final datasets = _addFetchDataToDataset(list);

          if (list.isEmpty) {
            if (widget.children.length > 1) {
              return RepaintBoundary(
                child: widget.children.last.toWidget(
                  state: widget.state.copyWith(dataset: datasets),
                ),
              );
            } else {
              return const Center(
                child: THeadline3(
                  'CMS Fetch returned an empty list. Add children to customize this message,',
                  isCentered: true,
                  color: Colors.grey,
                ),
              );
            }
          }

          return NodeSelectionBuilder(
            state: widget.state,
            child: widget.children.isEmpty
                ? const THeadline3('CMS Fetch requires at least one child')
                : RepaintBoundary(
                    child: widget.children.first.toWidget(
                      state: widget.state.copyWith(dataset: datasets),
                    ),
                  ),
          );
        },
      ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final List<dynamic>? list) {
    _map = _map.copyWith(
      name: widget.state.node.name ??
          widget.state.node.intrinsicState.displayName,
      map: (list ?? const <dynamic>[])
          .map((final dynamic e) => e as Map<String, dynamic>)
          .toList(),
    );

    final datasets = addDataset(context, widget.state.dataset, _map);

    return widget.state.dataset.isEmpty ? datasets : widget.state.dataset;
  }
}
