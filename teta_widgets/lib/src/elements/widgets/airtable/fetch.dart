// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAirtableFetch extends StatefulWidget {
  /// Construct
  const WAirtableFetch(
    final Key? key, {
    required this.node,
    required this.recordName,
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
  final FTextTypeInput recordName;

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
  _WAirtableFetchState createState() => _WAirtableFetchState();
}

class _WAirtableFetchState extends State<WAirtableFetch> {
  bool isInitialized = false;
  List<dynamic> list = <dynamic>[];
  DatasetObject _map = DatasetObject(
    name: 'Collection Query',
    map: [<String, dynamic>{}],
  );

  Future<void> getDbElements() async {
    final recordName = widget.recordName.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    final config =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
            .prj
            .config;
    var dbElements = <AirtableRecord>[];
    if (config != null && config.airtableEnabled) {
      final airtable = Airtable(
        apiKey: config.airtableKey!,
        projectBase: config.airtableProjectBase!,
      );
      dbElements = await airtable.getAllRecords(recordName);
    } else {
      dbElements = <AirtableRecord>[];
    }

    if (mounted) {
      setState(() {
        isInitialized = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDbElements();
  }

  @override
  Widget build(final BuildContext context) {
    final datasets = _addFetchDataToDataset(list);

    if (list.isEmpty) {
      if (widget.children.length > 1) {
        return RepaintBoundary(
          child: widget.children.last.toWidget(
            params: widget.params,
            states: widget.states,
            dataset: datasets,
            forPlay: widget.forPlay,
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
      node: widget.node,
      forPlay: widget.forPlay,
      child: widget.children.isEmpty
          ? const THeadline3('This node requires at least one child')
          : RepaintBoundary(
              child: widget.children.first.toWidget(
                params: widget.params,
                states: widget.states,
                dataset: datasets,
                forPlay: widget.forPlay,
              ),
            ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final List<dynamic>? list) {
    _map = _map.copyWith(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: (list ?? const <dynamic>[])
          .map((final dynamic e) => e as Map<String, dynamic>)
          .toList(),
    );

    final datasets = addDataset(context, widget.dataset, _map);

    return widget.dataset.isEmpty ? datasets : widget.dataset;
  }
}
