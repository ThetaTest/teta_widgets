// Flutter imports:
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:adapty_flutter/models/adapty_product.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:teta_models/teta_models.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WAdaptyProductsList extends StatefulWidget {
  /// Returns a [WAdaptyProductsList] widget in Teta
  const WAdaptyProductsList(
    final Key? key, {
    required this.state,
    required this.paywallId,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput paywallId;
  final CNode? child;

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
      name: widget.state.node.name ??
          widget.state.node.intrinsicState.displayName,
      map: const [<String, dynamic>{}],
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
                widget.state.params,
                widget.state.states,
                widget.state.dataset,
                widget.state.forPlay,
                widget.state.loop,
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
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    _map = _map.copyWith(
      name: widget.state.node.name ??
          widget.state.node.intrinsicState.displayName,
      //! Commented out because .toJson() method is not available in AdaptyProduct
      // map: products.map((final e) => e.toJson()).toList(),
    );
    final datasets = addDataset(context, _map);

    return NodeSelectionBuilder(
      state: widget.state,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.child == null ? 1 : products.length,
        itemBuilder: (final context, final index) => ChildConditionBuilder(
          ValueKey('${widget.state.node.nid} ${widget.state.loop}'),
          state: widget.state.copyWith(
            dataset:
                widget.state.dataset.isEmpty ? datasets : widget.state.dataset,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
