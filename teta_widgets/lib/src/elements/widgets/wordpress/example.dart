// Flutter imports:
// ignore_for_file: public_member_api_docs

/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teta_front_end/src/design_system/text.dart';
import 'package:teta_core/src/elements/builder/add_dataset.dart';
import 'package:teta_core/src/elements/builder/node_selection_builder.dart';
import 'package:teta_core/src/elements/nodes/node.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_models/src/models/variable.dart';
import 'package:teta_core/src/utils/shopify/flutter_simple_shopify.dart';
import 'package:teta_core/src/utils/shopify/models/models.dart';
import 'package:teta_core/src/utils/wordpress/flutter_wordpress.dart' as wp;

class WWordPressExampleGridview extends StatefulWidget {
  const WWordPressExampleGridview({
    Key? key,
    this.child,
    required this.node,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  _WWordPressExampleGridviewState createState() =>
      _WWordPressExampleGridviewState();
}

class _WWordPressExampleGridviewState extends State<WWordPressExampleGridview> {
  List<Product> products = [];
  DatasetObject map = DatasetObject.empty;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    if (_isLoading) _fetchProducts(context);
    final list = addDataset(context,  map);
    return _isLoading
        ? const CircularProgressIndicator()
        : StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(8),
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
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
                : const CText('Example Wordpress'),
            //productThumbnail(products[index]),
          );
  }

  Future<void> _fetchProducts(BuildContext context) async {
    try {
      wp.WordPress wordPress;

      wordPress = wp.WordPress(
        baseUrl: 'https://andreabuttarelli.com/wp_example',
        authenticator: wp.WordPressAuthenticator.JWT,
      );

      final posts = await wordPress.fetchPosts(
        postParams: wp.ParamsPostList(
          perPage: 20,
        ),
        fetchFeaturedMedia: true,
      );
      if (mounted) {
        setState(() {
          map = DatasetObject(
            name: 'Example Wordpress',
            map: posts.map((e) => e.toJson()).toList(),
          );
          _isLoading = false;
        });
      }
    } catch (_) {}
  }
}
*/
