// Flutter imports:
// Package imports:
// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/filter.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/controls/filter_control.dart';


// ignore_for_file: public_member_api_docs

class WSupabaseFutureBuilder extends StatefulWidget {
  /// Construct
  const WSupabaseFutureBuilder(final Key? key, {
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
    required this.filters,
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

  final List<QueryFilter> filters;

  /// The opzional child of this widget
  final List<CNode> children;

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

    client = BlocProvider
        .of<SupabaseCubit>(context)
        .state;
    final query = client!.from(from).select(select);

    final filters = widget.filters;

    if (filters.isNotEmpty) {
      for (final element in filters) {
        query.filter(
          element.columnName,
          element.filter.convertToSupabaseFilter(),
          element.value,
        );
      }
    }

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
  Widget build(final BuildContext context) {
    if (client == null) {
      return const Center(
        child: THeadline3(
          'Supabase is not initialized yet',
        ),
      );
    }

    return NodeSelectionBuilder(
      node: widget.state.node,
      forPlay: widget.state.forPlay,
      child: FutureBuilder(
        future: _future,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            if (widget.children.isNotEmpty) {
              return widget.children.last.toWidget(state: widget.state);
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
            name: widget.state.node.name ??
                widget.state.node.intrinsicState.displayName,
            map: (list ?? const <dynamic>[])
                .map((final dynamic e) => e as Map<String, dynamic>)
                .toList(),
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
