// Flutter imports:
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WQonversionProductsList extends StatefulWidget {
  /// Returns a [WQonversionProductsList] widget in Teta
  const WQonversionProductsList(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WQonversionProductsList> createState() =>
      _WQonversionProductsListState();
}

class _WQonversionProductsListState extends State<WQonversionProductsList> {
  List<StoreProduct> products = [];
  bool isLoading = true;
  late DatasetObject _map;

  @override
  void initState() {
    getProducts();
    _map = DatasetObject(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: [<String, dynamic>{}],
    );
    super.initState();
  }

  Future<void> getProducts() async {
    setState(() {
      products = [
        const StoreProduct(
          'identifier',
          'This is just a mockup',
          'Mockup',
          9.99,
          'priceString',
          'currencyCode',
        ),
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(final BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    _map = _map.copyWith(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: products.map((final e) => e.toJson()).toList(),
    );
    final datasets = addDataset(context, widget.dataset, _map);

    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: widget.node,
        params: widget.params,
        states: widget.states,
        dataset: widget.dataset,
        forPlay: widget.forPlay,
        loop: widget.loop,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.child == null ? 1 : products.length,
          itemBuilder: (final context, final index) => ChildConditionBuilder(
            ValueKey('${widget.node.nid} ${widget.loop}'),
            name: NodeType.name(NType.align),
            node: widget.node,
            child: widget.child,
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset.isEmpty ? datasets : widget.dataset,
            forPlay: widget.forPlay,
            loop: widget.loop,
          ),
        ),
      ),
    );
  }
}
