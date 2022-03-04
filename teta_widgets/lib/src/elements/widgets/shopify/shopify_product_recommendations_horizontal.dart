/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyProductRecommendations extends StatefulWidget {
  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyProductRecommendations({
    Key? key,
    this.child,
    required this.node,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  @override
  _WShopifyProductRecommendationsState createState() =>
      _WShopifyProductRecommendationsState();
}

class _WShopifyProductRecommendationsState
    extends State<WShopifyProductRecommendations> {
  List<Product> products = [];
  bool _isLoading = true;
  DatasetObject map = DatasetObject(
    name: "Shopify Product Recommendations",
    map: [Product().toJson()],
  );

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    String? id;
    try {
      widget.params.forEach((element) {
        if (element.name == "id") id = element.value ?? element.defaultValue;
      });
    } catch (e) {}
    final List<DatasetObject> list = [];
    list.addAll(widget.dataset);
    list.add(map);
    if (_isLoading) _fetchProducts(context, id);
    final prjState = BlocProvider.of<FocusProjectBloc>(context).state;
    final pageFocused = BlocProvider.of<FocusPageBloc>(context).state;
    try {
      if (pageFocused.scaffold!.dataset != null) {
        bool flag = true;
        pageFocused.scaffold!.dataset!.forEach((element) {
          if (element.name == map.name) flag = false;
        });
        if (flag) pageFocused.scaffold!.dataset!.add(map);
      } else
        pageFocused.scaffold!.dataset = [map];
      if (prjState is ProjectLoaded) {
        prjState.prj.pages!.forEach((element) {
          if (element.id == pageFocused.id) {
            if (element.scaffold!.dataset != null) {
              bool flag = true;
              element.scaffold!.dataset!.forEach((element) {
                if (element.name == map.name) flag = false;
              });
              if (flag) element.scaffold!.dataset!.add(map);
            } else
              element.scaffold!.dataset = [map];
          }
        });
      }
    } catch (e) {}
    return Container(
      width: double.maxFinite,
      height: 250,
      child: _isLoading && widget.forPlay
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: widget.forPlay ? products.length : 1,
              itemBuilder: (_, int index) => widget.child != null
                  ? widget.child!.toWidget(
                      forPlay: widget.forPlay,
                      params: [...widget.params, ...widget.params],
                      states: widget.states,
                      dataset: list,
                      loop: index,
                    )
                  : const CText('GridView'),
            ),
    );
  }

  Future<void> _fetchProducts(BuildContext context, String? id) async {
    if (id != null) {
      try {
        ShopifyStore shopifyStore = ShopifyStore.instance;
        List<Product> productsList =
            await shopifyStore.getProductRecommendations(id);
        print("recommendations: $productsList");
        if (productsList.isEmpty) {
          productsList = await shopifyStore.getNProducts(10,
              sortKey: SortKeyProduct.BEST_SELLING);
        }
        if (mounted) {
          setState(() {
            map = DatasetObject(
              name: "Shopify Product Recommendations",
              map: productsList.isNotEmpty
                  ? productsList.map((e) => e.toJson()).toList()
                  : [Product().toJson()],
            );
            products = productsList;
            _isLoading = false;
          });
        }
      } catch (e) {
        print(e);
      }
    } else {
      if (mounted) {
        setState(() {
          products = [];
          _isLoading = false;
        });
      }
    }
  }
}
*/
