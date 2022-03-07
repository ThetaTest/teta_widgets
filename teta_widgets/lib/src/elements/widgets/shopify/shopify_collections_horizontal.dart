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
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyCollectionsHorizontal extends StatefulWidget {
  final CNode node;
  final String? nid;
  final String? parent;
  final CNode? child;
  final bool forPlay;
  final double index;
  final String? component;
  final int loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyCollectionsHorizontal({
    Key? key,
    this.child,
    required this.node,
    this.nid,
    this.parent,
    required this.forPlay,
    required this.index,
    this.component,
    required this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  @override
  _WShopifyCollectionsHorizontalState createState() =>
      _WShopifyCollectionsHorizontalState();
}

class _WShopifyCollectionsHorizontalState
    extends State<WShopifyCollectionsHorizontal> {
  List<Collection> collections = [];
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
              nid: widget.nid,
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
    return Container(
      width: double.maxFinite,
      height: 500,
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
                itemCount: collections.length,
                itemBuilder: (_, int index) => (widget.child != null)
                    ? widget.child!.toWidget(
                        forPlay: widget.forPlay,
                        params: [...widget.params, ...widget.params],
                        states: widget.states,
                        dataset: list,
                        loop: index,
                      )
                    : const CText('Insert here'),
              ),
            ),
    );
  }

  Widget collectionThumbnail(Collection collection) {
    return InkWell(
      onTap: () => /*_navigateToProductDetailScreen(product)*/ {},
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: collection.image?.originalSource != null
            ? BoxDecoration(
                color: Colors.black38,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      collection.image!.originalSource!,
                    )))
            : BoxDecoration(
                color: Colors.black38,
              ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Text(
            collection.title!,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchProducts(BuildContext context) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      final List<Collection> collectionsList =
          await shopifyStore.getAllCollections();
      if (mounted) {
        setState(() {
          map = DatasetObject(
            name: "Shopify Collections",
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
