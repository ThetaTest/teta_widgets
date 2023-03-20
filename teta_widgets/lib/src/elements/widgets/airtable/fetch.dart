// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/src/cubits/airtable.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

// ignore_for_file: public_member_api_docs

class WAirtableFetch extends StatefulWidget {
  /// Construct
  const WAirtableFetch(
    final Key? key, {
    required this.state,
    required this.recordName,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The from's value
  final FTextTypeInput recordName;

  /// The opzional child of this widget
  final List<CNode> children;

  @override
  _WAirtableFetchState createState() => _WAirtableFetchState();
}

class _WAirtableFetchState extends State<WAirtableFetch> with AfterLayoutMixin {
  bool isInitialized = false;
  List<dynamic> list = <dynamic>[];
  DatasetObject _map = DatasetObject(
    name: 'Collection Query',
    map: [<String, dynamic>{}],
  );

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    getDbElements();
  }

  Future<void> getDbElements() async {
    final recordName = widget.recordName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final config =
        (BlocProvider.of<ConfigCubit>(context).state as ConfigStateLoaded)
            .config;
    var dbElements = <AirtableRecord>[];
    if (config.airtable is AirtableConfigModelInitialized) {
      final airtable = context.read<AirtableCubit>();
      dbElements = await airtable.getAllRecords(recordName);
    } else {
      dbElements = <AirtableRecord>[];
    }

    if (mounted) {
      setState(() {
        list = dbElements;
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    final datasets = _addFetchDataToDataset(list);

    if (list.isEmpty) {
      if (widget.children.length > 1) {
        return RepaintBoundary(
          child: widget.children.last.toWidget(
            state: widget.state.copyWith(
              dataset: datasets,
            ),
          ),
        );
      } else {
        return const THeadline3(
          'This node just returned an empty list. Add children to customize this message,',
          isCentered: true,
        );
      }
    }

    return NodeSelectionBuilder(
      state: widget.state,
      child: widget.children.isEmpty
          ? const THeadline3('This node requires at least one child')
          : RepaintBoundary(
              child: widget.children.first.toWidget(
                state: widget.state.copyWith(
                  dataset: datasets,
                ),
              ),
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

    final datasets = addDataset(context, _map);

    return widget.state.dataset.isEmpty ? datasets : widget.state.dataset;
  }
}
