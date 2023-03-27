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
import 'package:theta_models/theta_models.dart';

class WTetaStoreTransactionsBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WTetaStoreTransactionsBuilder(
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
  WTetaStoreTransactionsBuilderState createState() =>
      WTetaStoreTransactionsBuilderState();
}

class WTetaStoreTransactionsBuilderState
    extends State<WTetaStoreTransactionsBuilder> {
  bool isLoading = true;

  @override
  void initState() {
    _getTransactions().whenComplete(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    _getTransactions().whenComplete(() {
      if (mounted) {
        setState(() {});
      }
    });

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
            ? widget.child!.toWidget(
                state: widget.state.copyWith(loop: index),
              )
            : PlaceholderChildBuilder(
                name: widget.state.node.intrinsicState.displayName,
                node: widget.state.node,
                forPlay: widget.state.forPlay,
              ),
      ),
    );
  }

  Future _getTransactions() async {
    try {
      final r = await TetaCMS.instance.store.transactions();
      if (r.data != null) {
        final datasetObject = DatasetObject(
          name: 'transactions',
          map: r.data!.map((final e) => e.toJson()).toList(growable: true),
        );
        addDataset(context, datasetObject);
      } else {
        debugPrint(
            'Error in calc _getTransactions -> ${r.error?.message ?? 'no message'}');
      }
    } catch (e) {
      debugPrint('Error in calc _getTransactions -> $e');
    }
  }
}
