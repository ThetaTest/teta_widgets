// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WStripeCartItemsBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WStripeCartItemsBuilder(
    final Key? key, {
    required this.child,
    required this.node,
    required this.forPlay,
    required this.value,
    required this.shrinkWrap,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final bool shrinkWrap;
  final bool isVertical;
  final FDataset value;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  _WStripeCartItemsBuilderState createState() =>
      _WStripeCartItemsBuilderState();
}

class _WStripeCartItemsBuilderState extends State<WStripeCartItemsBuilder> {
  bool isLoading = true;

  @override
  void initState() {
    _getStripeProducts().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    _getStripeProducts().whenComplete(() {
      setState(() {});
    });
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
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          shrinkWrap: widget.shrinkWrap,
          scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: widget.dataset
              .firstWhere(
                (final element) => element.getName.contains('cart'),
                orElse: DatasetObject.empty,
              )
              .getMap
              .length,
          itemBuilder: (final context, final index) => widget.child != null
              ? widget.child!.toWidget(
                  forPlay: widget.forPlay,
                  params: widget.params,
                  states: widget.states,
                  dataset: widget.dataset,
                  loop: index,
                )
              : PlaceholderChildBuilder(
                  name: widget.node.intrinsicState.displayName,
                  node: widget.node,
                  forPlay: widget.forPlay,
                ),
        ),
      ),
    );
  }

  Future _getStripeProducts() async {
    try {
      final tetaCms = TetaCMS.instance;
      final products = await tetaCms.store.cart.get();

      if (products.data != null) {
        final datasetObject = DatasetObject(
          name: 'cart',
          map: products.data!.map((final e) => e.toJson()).toList(growable: true),
        );
        addDataset(context, widget.dataset, datasetObject);
      } else {
        debugPrint(
            'Error in calc WStripeProductsCartList -> ${products.error?.message ?? 'no message'}');
      }
    } catch (e) {
      debugPrint('Error in calc WStripeProductsCartList -> $e');
    }
  }
}
