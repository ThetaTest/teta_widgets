// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

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

    _stream = query.execute();
  }

  @override
  Widget build(final BuildContext context) {
    final client = BlocProvider.of<SupabaseCubit>(context).state;

    if (client == null) {
      return const Center(
        child: THeadline3(
          'Supabase is not initialized yet',
        ),
      );
    }

    return NodeSelectionBuilder(
      state: widget.state,
      child: StreamBuilder(
        stream: _stream,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            // snapshot has no data yet
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(
                state: widget.state,
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
            name: widget.state.node.name ??
                widget.state.node.intrinsicState.displayName,
            map: response?.map((final Map<String, dynamic> e) => e).toList(),
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
        },
      ),
    );
  }
}
