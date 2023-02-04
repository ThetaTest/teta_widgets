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
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

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
    required this.containsName,
    required this.containsValue,
    required this.filterName,
    required this.filterValue,
    required this.filterOperator,
    required this.gtName,
    required this.gtValue,
    required this.gtEName,
    required this.gtEValue,
    required this.ltName,
    required this.ltValue,
    required this.ltEName,
    required this.ltEValue,
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
  final FTextTypeInput containsName;
  final FTextTypeInput containsValue;
  final FTextTypeInput filterName;
  final FTextTypeInput filterValue;
  final FTextTypeInput filterOperator;
  final FTextTypeInput gtName;
  final FTextTypeInput gtValue;
  final FTextTypeInput gtEName;
  final FTextTypeInput gtEValue;
  final FTextTypeInput ltName;
  final FTextTypeInput ltValue;
  final FTextTypeInput ltEName;
  final FTextTypeInput ltEValue;

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
    final ltEName = widget.ltEName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final ltEValue = widget.ltEValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final ltName = widget.ltName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final ltValue = widget.ltValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final gtEName = widget.gtEName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final gtEValue = widget.gtEValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final gtName = widget.gtName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final gtValue = widget.gtValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final filterName = widget.filterName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final filterValue = widget.filterValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final filterOperator = widget.filterOperator.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );

    final containName = widget.containsName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );

    final containValue = widget.containsValue.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
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

    // ignore: literal_only_boolean_expressions
    if (order.isNotEmpty) {
      query.order(order, ascending: true);
    }
    if (gtName.isNotEmpty) {
      query.gt(gtName, gtValue);
    }

    if (gtEName.isNotEmpty) {
      query.gte(gtEName, gtEValue);
    }

    if (ltName.isNotEmpty) {
      query.lt(ltName, ltValue);
    }

    if (ltEName.isNotEmpty) {
      query.lte(ltEName, ltEValue);
    }

    if (filterName.isNotEmpty) {
      query.filter(filterName, filterOperator, filterValue);
    }
    if (containName.isNotEmpty) {
      query.contains(containName, int.tryParse(containValue) ?? 0);
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
      state: widget.state,
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
