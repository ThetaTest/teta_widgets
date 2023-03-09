// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTetaStoreCartItemsBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WTetaStoreCartItemsBuilder(
    final Key? key, {
    required this.state,
    required this.child,
    required this.value,
    required this.shrinkWrap,
    required this.isVertical,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final bool shrinkWrap;
  final bool isVertical;
  final FDataset value;

  @override
  _WTetaStoreCartItemsBuilderState createState() =>
      _WTetaStoreCartItemsBuilderState();
}

class _WTetaStoreCartItemsBuilderState
    extends State<WTetaStoreCartItemsBuilder> {
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
    return TetaWidget(
      state: widget.state,
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: widget.state.dataset
            .firstWhere(
              (final element) => element.getName.contains('cart'),
              orElse: DatasetObject.empty,
            )
            .getMap
            .length,
        itemBuilder: (final context, final index) => widget.child != null
            ? widget.child!.toWidget(state: widget.state.copyWith(loop: index))
            : PlaceholderChildBuilder(
                name: widget.state.node.intrinsicState.displayName,
                node: widget.state.node,
                forPlay: widget.state.forPlay,
              ),
      ),
    );
  }

  Future _getStripeProducts() async {
    try {
      final tetaCms = TetaCMS.instance;
      final products = await tetaCms.store.cart.get();

      if (products.data != null) {
        final uniqueProducts = <Map<String, dynamic>>[];
        for (final e in products.data!) {
          final index = uniqueProducts
              .indexWhere((final element) => element['_id'] == e.id);
          if (index == -1) {
            uniqueProducts.add(
              <String, dynamic>{
                '_id': e.id,
                'quantity': 1,
                ...e.toJson(),
              },
            );
          } else {
            uniqueProducts[index]['quantity']++;
          }
        }
        final datasetObject = DatasetObject(
          name: 'cart',
          map: uniqueProducts,
        );
        addDataset(context, datasetObject);
      } else {
        debugPrint(
          'Error in calc WStripeProductsCartList -> ${products.error?.message ?? 'no message'}',
        );
      }
    } catch (e) {
      debugPrint('Error in calc WStripeProductsCartList -> $e');
    }
  }
}
