// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WSupabaseFutureBuilder extends StatefulWidget {
  /// Construct
  const WSupabaseFutureBuilder(
    Key? key, {
    required this.node,
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
  _WSupabaseFutureBuilderState createState() => _WSupabaseFutureBuilderState();
}

class _WSupabaseFutureBuilderState extends State<WSupabaseFutureBuilder> {
  DatasetObject _map = DatasetObject(
    name: 'Supabase Query',
    map: [<String, dynamic>{}],
  );
  bool isLoaded = true;
  Future<PostgrestResponse>? _future;
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
    final select = widget.select.get(
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
    final toRange = widget.toRange.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final valueToRange =
        int.tryParse(toRange) != null ? int.parse(toRange) : 15;
    final numberPage = widget.numberPage.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final valueToPage =
        int.tryParse(numberPage) != null ? int.parse(numberPage) : 1;

    final searchName = widget.searchName.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final searchValue = widget.searchValue.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );

    final eqName = widget.eqName.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final eqValue = widget.eqValue.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );

    client = BlocProvider.of<SupabaseCubit>(context).state;
    final query = client!.from(from).select(select);

    // ignore: literal_only_boolean_expressions
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
    if (true) {
      query.range(valueFromRange, valueToRange * valueToPage);
    }

    _future = query.execute();
  }

  @override
  Widget build(BuildContext context) {
    if (client == null) {
      return const Center(
        child: CText(
          'Supabase is not initialized yet',
          customColor: Colors.white,
        ),
      );
    }

    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
          final response = snapshot.data as PostgrestResponse?;
          if (response?.error != null) {
            // TODO: Returns a error widget
          }
          if (response?.data.runtimeType != List) {
            // TODO: Returns a message error, probably from and select are not selected well
          }
          final list = response?.data as List<dynamic>?;
          _map = _map.copyWith(
            name: widget.node.name ?? widget.node.intrinsicState.displayName,
            map: (list ?? const <dynamic>[])
                .map((dynamic e) => e as Map<String, dynamic>)
                .toList(),
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
      ),
    );
  }
}
