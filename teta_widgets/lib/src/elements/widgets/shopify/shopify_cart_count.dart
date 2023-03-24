/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/cubits/local_shopify_cart/cubit.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/builder/draggable.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyCartCount extends StatefulWidget {
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

  WShopifyCartCount({
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
  _WShopifyCartState createState() => _WShopifyCartState();
}

class _WShopifyCartState extends State<WShopifyCartCount> {
  int count = 0;
  DatasetObject map = DatasetObject(
    name: "Shopify Cart Count",
    map: [
      {"count": 0}
    ],
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
                      'Shopify User',
                      size: 16,
                      color: Palette.black,
                    ),
                    /*GestureDetector(
                  child: const Icon(Icons.info, size: 24, color: Colors.black),
                ),*/
                  ],
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
      if (mounted) {
        final length = ids.toSet().toList().length;
        setState(() {
          map = DatasetObject(
            name: "Shopify Cart Count",
            map: [
              {"count": length}
            ],
          );
          count = length;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
*/
