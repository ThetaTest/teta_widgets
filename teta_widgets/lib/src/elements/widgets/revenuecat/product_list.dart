// Flutter imports:
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:teta_models/teta_models.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WRevenueCatProductsList extends StatefulWidget {
  /// Returns a [WRevenueCatProductsList] widget in Teta
  const WRevenueCatProductsList(
    final Key? key, {
    required this.state,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;

  @override
  State<WRevenueCatProductsList> createState() =>
      _WRevenueCatProductsListState();
}

class _WRevenueCatProductsListState extends State<WRevenueCatProductsList> {
  List<Product> products = [];
  bool isLoading = true;
  late DatasetObject _map;

  @override
  void initState() {
    getProducts();
    _map = DatasetObject(
      name: widget.state.node.name ??
          widget.state.node.intrinsicState.displayName,
      map: const [<String, dynamic>{}],
    );
    super.initState();
  }

  Future<void> getProducts() async {
    if (UniversalPlatform.isAndroid) {
      try {
        final offerings = await Purchases.getOfferings();
        if (offerings.current != null &&
            (offerings.current?.availablePackages ?? []).isNotEmpty) {
          final prods = <Product>[];
          for (final product
              in offerings.current?.availablePackages ?? <Package>[]) {
            prods.add(product.product);
          }
          products = prods;
        }
      } catch (e) {
        Logger.printError('$e');
      }
    } else {
      products = [
        const Product(
          'identifier',
          'This is just a mockup',
          'Mockup',
          9.99,
          'priceString',
          'currencyCode',
        ),
      ];
    }
    setState(() {
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
      name: widget.state.node.name ??
          widget.state.node.intrinsicState.displayName,
      map: products.map((final e) => e.toJson()).toList(),
    );
    final datasets = addDataset(context, _map);

    return TetaWidget(
      state: widget.state,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.child == null ? 1 : products.length,
        itemBuilder: (final context, final index) => ChildConditionBuilder(
          ValueKey('${widget.state.node.nid} ${widget.state.loop}'),
          state: widget.state.copyWith(
            dataset:
                widget.state.dataset.isEmpty ? datasets : widget.state.dataset,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
