import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
import '../../../core/teta_widget/index.dart';
import '../../index.dart';

class WSupabaseFutureBuilder extends StatefulWidget {
  /// Construct
  const WSupabaseFutureBuilder(
    final Key? key, {
    required this.state,
    required this.from,
    required this.select,
    required this.order,
    required this.fromRange,
    required this.toRange,
    required this.numberPage,
    required this.searchName,
    required this.searchValue,
    required this.eqName,
    required this.eqValue,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The from's value
  final FTextTypeInput from;

  /// The select's value
  final FTextTypeInput select;

  /// The select's value
  final FTextTypeInput order;

  /// The select's value
  final FTextTypeInput fromRange;

  /// The select's value
  final FTextTypeInput numberPage;

  /// The select's value
  final FTextTypeInput toRange;

  final FTextTypeInput searchName;
  final FTextTypeInput searchValue;
  final FTextTypeInput eqName;
  final FTextTypeInput eqValue;

  /// The opzional child of this widget
  final List<CNode> children;

  @override
  _WSupabaseFutureBuilderState createState() => _WSupabaseFutureBuilderState();
}

class _WSupabaseFutureBuilderState extends State<WSupabaseFutureBuilder> {
  DatasetObject _map = const DatasetObject(
    name: 'Supabase Query',
    map: [<String, dynamic>{}],
  );
  bool isLoaded = true;
  Future<PostgrestResponse>? _future;
  SupabaseClient? client;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => calc());
  }

  Future calc() async {
    if (_future != null) return;

    final from = widget.from.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final select = widget.select.get(
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
    final toRange = widget.toRange.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final valueToRange =
        int.tryParse(toRange) != null ? int.parse(toRange) : 15;
    final numberPage = widget.numberPage.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final valueToPage =
        int.tryParse(numberPage) != null ? int.parse(numberPage) : 1;

    final searchName = widget.searchName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final searchValue = widget.searchValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );

    final eqName = widget.eqName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final eqValue = widget.eqValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );

    client = BlocProvider.of<SupabaseCubit>(context).state;
    final query = client!.from(from).select(select);

    if (order.isNotEmpty) {
      query.order(order, ascending: true);
    }
    if (searchName.isNotEmpty) {
      //query.textSearch(searchName, searchValue, type: TextSearchType.plain);
      query.ilike(searchName, '%$searchValue%');
    }
    if (eqName.isNotEmpty) {
      if (eqName == 'id') {
        query.eq(eqName, int.tryParse(eqValue) ?? 0);
      } else {
        query.eq(eqName, eqValue);
      }
    }
    // ignore: literal_only_boolean_expressions
    query.range(valueFromRange, valueToRange * valueToPage);

    setState(() => _future = query.execute());
  }

  @override
  Widget build(final BuildContext context) {
    if (client == null) {
      return const Center(
        child: THeadline3('Supabase is not initialized yet'),
      );
    }

    return NodeSelectionBuilder(
      state: widget.state,
      child: FutureBuilder(
        future: _future,
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

          final response = snapshot.data as PostgrestResponse?;
          if (response?.error != null) {
            return Text(
              'Supabase error while fetching data: ${response?.error}',
            );
          }
          if (response?.data.runtimeType != List) {
            return const Text(
              'Supabase error while fetching data. '
              'Check if "from" and "select" are correctly setupped.',
            );
          }
          final list = response?.data as List<dynamic>?;
          _map = _map.copyWith(
            name: widget.state.node.name ??
                widget.state.node.intrinsicState.displayName,
            map: (list ?? const <dynamic>[]).cast<Map<String, dynamic>>(),
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
    );
  }
}
