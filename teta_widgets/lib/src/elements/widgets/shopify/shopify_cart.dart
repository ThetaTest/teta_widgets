/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/cubits/local_shopify_cart/cubit.dart';
import 'package:mobile_editor/src/elements/builder/draggable.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';
import 'package:mobile_editor/src/utils/shopify/shopify/shopify.dart';

class WShopifyCart extends StatefulWidget {
  final CNode node;
  final CNode? child;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyCart({
    Key? key,
    this.child,
    required this.node,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  @override
  _WShopifyCartState createState() => _WShopifyCartState();
}

class _WShopifyCartState extends State<WShopifyCart> {
  List<Product> products = [];
  DatasetObject map = DatasetObject(
    name: "Shopify Cart",
    map: [Product().toJson()],
  );
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return (!widget.forPlay)
        ? DraggableNode(
            node: widget.node,
            child: NodeSelection(
              node: widget.node,
              forPlay: widget.forPlay,
              nid: widget.node.nid,
              child: body(context),
            ),
            forPlay: widget.forPlay,
          )
        : body(context);
  }

  Widget body(BuildContext context) {
    return BlocBuilder<LocalShopifyCart, List<String>>(
      builder: (context, state) {
        final List<DatasetObject> list = [];
        list.addAll(widget.dataset);
        list.add(map);
        if (_isLoading) _fetchProducts(context, state);
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
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(8),
                  itemCount: products.length,
                  itemBuilder: (_, int index) => widget.child != null
                      ? widget.child!.toWidget(
                          forPlay: widget.forPlay,
                          params: [...widget.params, ...widget.params],
                          states: widget.states,
                          dataset: list,
                          loop: index,
                        )
                      : collectionThumbnail(products[index]),
                ),
        );
      },
    );
  }

  Widget collectionThumbnail(Product order) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,
      child: Text(
        "${order.title}",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _fetchProducts(BuildContext context, List<String> ids) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      final List<Product> productsList =
          await shopifyStore.getProductsByIds(ids.toSet().toList());
      if (mounted) {
        setState(() {
          map = DatasetObject(
            name: "Shopify Cart",
            map: productsList.map((e) => e.toJson()).toList(),
          );
          products = productsList;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
*/
