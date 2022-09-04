/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyProduct extends StatefulWidget {
  final CNode node;
  final String? nid;
  final String? parent;
  final CNode? child;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyProduct({
    Key? key,
    this.child,
    required this.node,
    this.nid,
    this.parent,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  @override
  _WShopifyProductState createState() => _WShopifyProductState();
}

class _WShopifyProductState extends State<WShopifyProduct> {
  List<Product> products = [];
  bool _isLoading = true;
  DatasetObject map = DatasetObject(
    name: "Shopify Product",
    map: [Product().toJson()],
  );

  Widget build(BuildContext context) {
    String? id;
    try {
      widget.params.forEach((element) {
        if (element.name == "id") {
          id = element.value ?? element.defaultValue;
          return;
        }
      });
    } catch (e) {}
    final List<DatasetObject> list = [];
    list.addAll(widget.dataset);
    list.add(map);
    if (_isLoading) _fetchProducts(context, id);
    final prjState = BlocProvider.of<FocusProjectBloc>(context).state;
    final pageFocused = BlocProvider.of<PageCubit>(context).state;
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
    return widget.child != null
        ? widget.child!.toWidget(
            forPlay: widget.forPlay,
            params: [...widget.params, ...widget.params],
            states: widget.states,
            dataset: list,
            loop: 0,
          )
        : Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CText(
                  'Shopify Product',
                  size: 16,
                  color: Palette.black,
                ),
                /*GestureDetector(
                  child: const Icon(Icons.info, size: 24, color: Colors.black),
                ),*/
              ],
            ),
          );
  }

  Future<void> _fetchProducts(BuildContext context, String? id) async {
    if (id != null) {
      try {
        ShopifyStore shopifyStore = ShopifyStore.instance;
        final List<Product> productsList =
            await shopifyStore.getProductsByIds([id]);
        if (mounted) {
          setState(() {
            map = DatasetObject(
              name: "Shopify Product",
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
    }
  }
}
*/
