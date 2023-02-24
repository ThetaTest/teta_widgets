// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:

import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTetaStoreProductsBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WTetaStoreProductsBuilder(
    final Key? key, {
    required this.state,
    required this.child,
    required this.value,
    required this.shrinkWrap,
    required this.isVertical,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final bool shrinkWrap;
  final bool isVertical;
  final FDataset value;

  @override
  WTetaStoreProductsBuilderState createState() =>
      WTetaStoreProductsBuilderState();
}

class WTetaStoreProductsBuilderState extends State<WTetaStoreProductsBuilder> {
  bool isLoading = true;

  @override
  void initState() {
    _getTetaStoreProducts().whenComplete(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: widget.state.dataset
            .firstWhere(
              (final element) => element.getName.contains('products'),
              orElse: DatasetObject.empty,
            )
            .getMap
            .length,
        itemBuilder: (final context, final index) => widget.child != null
            ? widget.child!.toWidget(state: widget.state.copyWith(loop: index))
            : PlaceholderChildBuilder(
                name: widget.state.node.intrinsicState.displayName,
                node: widget.state.node,
                forPlay: widget.state.forPlay,
              ),
      ),
    );
  }

  Future _getTetaStoreProducts() async {
    try {
      final r = await TetaCMS.instance.store.products.getAll();
      if (r.data != null) {
        final datasetObject = DatasetObject(
          name: 'products',
          map: r.data!
              .map(
                (final e) => <String, dynamic>{
                  '_id': e.id,
                  ...e.toJson(),
                },
              )
              .toList(growable: true),
        );
        addDataset(context, widget.state.dataset, datasetObject);
      } else {
        debugPrint(
          'Error in calc WTetaStoreProductsList -> ${r.error?.message ?? 'no message'}',
        );
      }
    } catch (e) {
      debugPrint('Error in calc WTetaStoreProductsList -> $e');
    }
  }
}
