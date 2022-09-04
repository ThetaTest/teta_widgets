/// FIXME: Need fixes

/*

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/focus_page/index.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/elements/builder/placeholder_child.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:mobile_editor/src/utils/shopify/models/models.dart';

class WShopifyArticlesFromBlog extends StatefulWidget {
  final CNode node;
  final String? nid;
  final String? parent;
  final FTextTypeInput value;
  final CNode? child;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WShopifyArticlesFromBlog({
    Key? key,
    this.child,
    required this.node,
    this.nid,
    required this.value,
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
  _WShopifyArticlesFromBlogState createState() =>
      _WShopifyArticlesFromBlogState();
}

class _WShopifyArticlesFromBlogState extends State<WShopifyArticlesFromBlog> {
  List<Article> articles = [];
  bool _isLoading = true;
  DatasetObject map = DatasetObject(
    name: "Shopify Articles Blog",
    map: [Product().toJson()],
  );

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    String? handle;
    try {
      widget.params.forEach((element) {
        if (element.name == "blogHandle")
          handle = element.value ?? element.defaultValue;
      });
    } catch (e) {}
    final List<DatasetObject> list = [];
    list.addAll(widget.dataset);
    list.add(map);
    if (_isLoading) _fetchProducts(context, handle);
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
    } catch (e) {
      print(e);
    }
    return widget.child != null
        ? widget.child!.toWidget(
            forPlay: widget.forPlay,
            params: [...widget.params, ...widget.params],
            states: widget.states,
            dataset: list,
            loop: 0,
          )
        : PlaceholderChildBuilder(name: '');
  }

  Future<void> _fetchProducts(BuildContext context, String? handle) async {
    if (handle != null) {
      try {
        ShopifyBlog shopifyStore = ShopifyBlog.instance;
        final Blog blog = await shopifyStore.getBlogByHandle(handle);
        final List<Article> articlesList = blog.articles!.articleList!;
        if (mounted) {
          setState(() {
            map = DatasetObject(
              name: "Shopify Articles Blog",
              map: articlesList.isNotEmpty
                  ? articlesList.map((e) => e.toJson()).toList()
                  : [Article().toJson()],
            );
            articles = articlesList;
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
