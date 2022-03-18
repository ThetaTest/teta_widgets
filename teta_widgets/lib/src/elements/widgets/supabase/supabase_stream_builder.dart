// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WSupabaseStreamBuilder extends StatefulWidget {
  /// Construct
  const WSupabaseStreamBuilder(
    final Key? key, {
    required this.node,
    required this.from,
    required this.order,
    required this.fromRange,
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
  final FTextTypeInput from;

  /// The select's value
  final FTextTypeInput order;

  /// The select's value
  final FTextTypeInput fromRange;

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
  _WSupabaseStreamBuilderState createState() => _WSupabaseStreamBuilderState();
}

class _WSupabaseStreamBuilderState extends State<WSupabaseStreamBuilder> {
  DatasetObject _map = DatasetObject(
    name: 'Supabase Query',
    map: [<String, dynamic>{}],
  );
  Stream<List<Map<String, dynamic>>>? _stream;
  SupabaseClient? client;

  @override
  void initState() {
    super.initState();
    calc();
  }

  Future calc() async {
    final from = widget.from.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final order = widget.order.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final fromRange = widget.fromRange.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final valueFromRange =
        int.tryParse(fromRange) != null ? int.parse(fromRange) : 0;

    client = BlocProvider.of<SupabaseCubit>(context).state;
    final query = client!.from(from).stream(['id']);

    // ignore: literal_only_boolean_expressions
    if (order.isNotEmpty) {
      query.order(order, ascending: true);
    }
    if (valueFromRange != 0) {
      query.limit(valueFromRange);
    }

    _stream = query.execute();
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: body(context),
    );
  }

  Widget body(final BuildContext context) {
    final client = BlocProvider.of<SupabaseCubit>(context).state;

    if (client == null) {
      return const Center(
        child: THeadline3(
          'Supabase is not initialized yet',
        ),
      );
    }

    return StreamBuilder(
      stream: _stream,
      builder: (final context, final snapshot) {
        if (!snapshot.hasData) {
          // snapshot has no data yet
          if (widget.children.isNotEmpty) {
            return widget.children.last.toWidget(
              params: widget.params,
              states: widget.states,
              dataset: widget.dataset,
              forPlay: widget.forPlay,
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
        if (snapshot.error != null) {
          // TODO: Returns a error widget
        }
        final response = snapshot.data as List<Map<String, dynamic>>?;
        if ((response ?? <Map<String, dynamic>>[]).isEmpty) {
          // TODO: Returns a error widget
        }
        _map = _map.copyWith(
          name: widget.node.name ?? widget.node.intrinsicState.displayName,
          map: response?.map((final Map<String, dynamic> e) => e).toList(),
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
    );
  }
}
