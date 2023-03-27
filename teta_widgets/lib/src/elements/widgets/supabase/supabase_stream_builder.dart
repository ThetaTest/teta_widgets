import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';

import '../../../core/teta_widget/index.dart';
import '../../index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class WSupabaseStreamBuilder extends StatefulWidget {
  /// Construct
  const WSupabaseStreamBuilder(
    final Key? key, {
    required this.state,
    required this.from,
    required this.order,
    required this.fromRange,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The from's value
  final FTextTypeInput from;

  /// The select's value
  final FTextTypeInput order;

  /// The select's value
  final FTextTypeInput fromRange;

  /// The optional child of this widget
  final List<CNode> children;

  @override
  _WSupabaseStreamBuilderState createState() => _WSupabaseStreamBuilderState();
}

class _WSupabaseStreamBuilderState extends State<WSupabaseStreamBuilder> {
  DatasetObject _map = const DatasetObject(
    name: 'Supabase Query',
    map: [<String, dynamic>{}],
  );
  Stream<List<Map<String, dynamic>>>? _stream;
  SupabaseClient? client;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => calc());
  }

  Future calc() async {
    if (_stream != null) return;

    final from = widget.from.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final order = widget.order.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final fromRange = widget.fromRange.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
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

    setState(() => _stream = query.execute());
  }

  @override
  Widget build(final BuildContext context) {
    final client = context.read<SupabaseCubit>().state;

    if (client == null) {
      return const Center(
        child: THeadline3('Supabase is not initialized yet'),
      );
    }

    if (_stream == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return NodeSelectionBuilder(
      state: widget.state,
      child: StreamBuilder(
        stream: _stream,
        builder: (final context, final snapshot) {
          if (snapshot.error != null) {
            return Text(
              'Supabase error while fetching data: ${snapshot.error}',
            );
          }

          if (!snapshot.hasData) {
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(
                state: widget.state,
              );
            } else {
              return const CircularProgressIndicator();
            }
          }

          final response = snapshot.data as List<Map<String, dynamic>>?;
          _map = _map.copyWith(
            name: widget.state.node.name ??
                widget.state.node.intrinsicState.displayName,
            map: response?.map((final Map<String, dynamic> e) => e).toList(),
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
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
