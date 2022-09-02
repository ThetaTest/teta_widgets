// Flutter imports:
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:adapty_flutter/models/adapty_product.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WAdaptyProductsList extends StatefulWidget {
  /// Returns a [WAdaptyProductsList] widget in Teta
  const WAdaptyProductsList(
    final Key? key, {
    required this.paywallId,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final FTextTypeInput paywallId;
  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WAdaptyProductsList> createState() => _WAdaptyProductsListState();
}

class _WAdaptyProductsListState extends State<WAdaptyProductsList> {
  List<AdaptyProduct> products = [];
  bool isLoading = true;
  late DatasetObject _map;

  @override
  void initState() {
    getProducts();
    _map = DatasetObject(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: [<String, dynamic>{}],
    );
    super.initState();
  }

  Future<void> getProducts() async {
    if (UniversalPlatform.isIOS ||
        UniversalPlatform.isAndroid ||
        UniversalPlatform.isMacOS) {
      try {
        AdaptyPaywall? myPaywall;
        final getPaywallsResult = await Adapty.getPaywalls();
        final paywalls = getPaywallsResult.paywalls;
        myPaywall = paywalls?.firstWhereOrNull(
          (final paywall) =>
              paywall.developerId ==
              widget.paywallId.get(
                widget.params,
                widget.states,
                widget.dataset,
                widget.forPlay,
                widget.loop,
                context,
              ),
        );
        products = myPaywall?.products ?? [];
      } catch (e) {
        Logger.printError('$e');
      }
    } else {
      products = [];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(final BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    _map = _map.copyWith(
      name: widget.node.name ?? widget.node.intrinsicState.displayName,
      map: products.map((final e) => e.toJson()).toList(),
    );
    final datasets = addDataset(context, widget.dataset, _map);

    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.child == null ? 1 : products.length,
        itemBuilder: (final context, final index) => ChildConditionBuilder(
          ValueKey('${widget.node.nid} ${widget.loop}'),
          name: NodeType.name(NType.align),
          node: widget.node,
          child: widget.child,
          params: widget.params,
          states: widget.states,
          dataset: widget.dataset.isEmpty ? datasets : widget.dataset,
          forPlay: widget.forPlay,
          loop: widget.loop,
        ),
      ),
    );
  }
}
