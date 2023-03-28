/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/cubits/zoomable/cubit.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/builder/draggable.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/features/sizes.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyProductsHorizontal extends StatefulWidget {
  final CNode node;
  final String? nid;
  final String? parent;
  final String? linkToPage;
  final FSize width;
  final FSize height;
  final CNode? child;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyProductsHorizontal({
    Key? key,
    this.child,
    required this.node,
    this.nid,
    this.parent,
    required this.forPlay,
    required this.width,
    required this.height,
    this.linkToPage,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  @override
  _WShopifyProductsHorizontalState createState() =>
      _WShopifyProductsHorizontalState();
}

class _WShopifyProductsHorizontalState
    extends State<WShopifyProductsHorizontal> {
  List<Product> products = [];
  DatasetObject map = DatasetObject();
  bool _isLoading = true;

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
    return SizedBox(
      width: widget.width.get(context: context, isWidth: true),
      height: widget.height.get(context: context, isWidth: false),
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MouseRegion(
              onEnter: (v) {
                BlocProvider.of<ZoomableCubit>(context)
                    .changeZoomableFlag(false);
              },
              onExit: (v) {
                BlocProvider.of<ZoomableCubit>(context)
                    .changeZoomableFlag(true);
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
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
                    : const CText('GridView'),
              ),
            ),
    );
  }

  Widget productThumbnail(Product product) {
    return GestureDetector(
      onTap: () {
        if (widget.forPlay) {
          final ProjectLoaded prj =
              BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
          final page = prj.prj.pages!
              .firstWhere((element) => element.id == widget.linkToPage);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page.scaffold!.toWidget(
                forPlay: widget.forPlay,
                params: page.scaffold!.params!.map((e) {
                  if (e.name == "id") e.value = product.id;
                  return e;
                }).toList(),
                states: widget.states,
                dataset: widget.dataset,
              ),
            ),
          );
        }
      },
      child: Container(
        width: 150,
        height: 400,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (product.images?.first.originalSource != null)
              Image.network(
                product.images!.first.originalSource!,
                fit: BoxFit.cover,
                width: 150,
                height: 200,
              ),
            Text(
              product.title!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
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
