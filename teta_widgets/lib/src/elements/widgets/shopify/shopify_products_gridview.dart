/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/builder/drag_target.dart';
import 'package:mobile_editor/src/elements/builder/draggable.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyProductsGridview extends StatefulWidget {
  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyProductsGridview({
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
  _WShopifyProductsGridviewState createState() =>
      _WShopifyProductsGridviewState();
}

class _WShopifyProductsGridviewState extends State<WShopifyProductsGridview> {
  List<Product> products = [];
  DatasetObject map = DatasetObject();
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
    final List<DatasetObject> list = [];
    list.addAll(widget.dataset);
    list.add(map);
    if (_isLoading) _fetchProducts(context);
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
    return Center(
      child: DragTargetWidget(
        node: widget.node,
        width: 50,
        height: 50,
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(8),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemCount: products.length,
                  itemBuilder: (_, int index) => widget.child != null
                      ? widget.child!.toWidget(
                          forPlay: widget.forPlay,
                          params: [...widget.params, ...widget.params],
                          states: widget.states,
                          dataset: list,
                          loop: index,
                        )
                      : const CText('GridView'),
                  //productThumbnail(products[index]),
                ),
        ),
      ),
    );
  }

  Future<void> _fetchProducts(BuildContext context) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      final List<Product> productsList = await shopifyStore.getNProducts(20);
      if (mounted) {
        setState(() {
          map = DatasetObject(
            name: "Shopify GridView",
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
