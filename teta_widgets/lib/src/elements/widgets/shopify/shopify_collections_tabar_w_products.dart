/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/builder/draggable.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyCollectionTabarWithProductsGridview extends StatefulWidget {
  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyCollectionTabarWithProductsGridview({
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
  _WShopifyCollectionTabarWithProductsGridviewState createState() =>
      _WShopifyCollectionTabarWithProductsGridviewState();
}

class _WShopifyCollectionTabarWithProductsGridviewState
    extends State<WShopifyCollectionTabarWithProductsGridview> {
  List<Collection> collections = [];
  List<Product> products = [];
  DatasetObject map = DatasetObject();
  DatasetObject mapProducts = DatasetObject();
  bool _isLoading = true;
  int collectionIndex = 0;

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
    if (_isLoading) _fetchCollections(context);
    final prjState = BlocProvider.of<FocusProjectBloc>(context).state;
    final pageFocused = BlocProvider.of<PageCubit>(context).state;
    if (!_isLoading && mounted) {
      setState(() {
        mapProducts = DatasetObject(
          name: "Shopify Products GridView",
          map: collections[collectionIndex]
              .products!
              .productList!
              .map((e) => e.toJson())
              .toList(),
        );
        list.add(mapProducts);
      });
    }
    try {
      if (pageFocused.scaffold!.dataset != null) {
        bool flag = true;
        pageFocused.scaffold!.dataset!.forEach((element) {
          if (element.name == map.name) flag = false;
        });
        if (flag) pageFocused.scaffold!.dataset!.add(map);
        flag = true;
        pageFocused.scaffold!.dataset!.forEach((element) {
          if (element.name == mapProducts.name) flag = false;
        });
        if (flag) pageFocused.scaffold!.dataset!.add(mapProducts);
      } else {
        pageFocused.scaffold!.dataset = [map, mapProducts];
      }
      if (prjState is ProjectLoaded) {
        prjState.prj.pages!.forEach((element) {
          if (element.id == pageFocused.id) {
            if (element.scaffold!.dataset != null) {
              bool flag = true;
              element.scaffold!.dataset!.forEach((element) {
                if (element.name == map.name) flag = false;
              });
              if (flag) element.scaffold!.dataset!.add(map);
              flag = true;
              element.scaffold!.dataset!.forEach((element) {
                if (element.name == mapProducts.name) flag = false;
              });
              if (flag) element.scaffold!.dataset!.add(mapProducts);
            } else {
              element.scaffold!.dataset = [map, mapProducts];
            }
          }
        });
      }
    } catch (e) {}
    return collections.length > 0
        ? Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: collections.length,
                  itemBuilder: (_, int index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        collectionIndex = index;
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 150,
                        height: 54,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(24)),
                        child:
                            Center(child: CText("${collections[index].title}")),
                      ),
                    ),
                  ),
                ),
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : collections[collectionIndex]
                          .products!
                          .productList!
                          .isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: collections[collectionIndex]
                              .products!
                              .productList!
                              .length,
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
                        )
                      : Container(
                          height: 50,
                          child: Center(child: CText('')),
                        ),
            ],
          )
        : CircularProgressIndicator();
  }

  Future<void> _fetchCollections(BuildContext context) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      final List<Collection> collectionsList =
          await shopifyStore.getXCollectionsAndNProductsSorted(10, 20);
      if (mounted) {
        setState(() {
          map = DatasetObject(
            name: "Shopify Collections Tabar",
            map: collectionsList.map((e) => e.toJson()).toList(),
          );
          collections = collectionsList;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
*/
