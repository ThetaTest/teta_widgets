// Flutter imports:
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WRevenueCatSingleSubStatus extends StatefulWidget {
  /// Returns a [WRevenueCatSingleSubStatus] widget in Teta
  const WRevenueCatSingleSubStatus(
    final Key? key, {
    required this.node,
    required this.entitlementInfo,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput entitlementInfo;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WRevenueCatSingleSubStatus> createState() =>
      _WRevenueCatSingleSubStatusState();
}

class _WRevenueCatSingleSubStatusState
    extends State<WRevenueCatSingleSubStatus> {
  Future<dynamic> getOffering() async {
    final offerings = await Purchases.getOfferings();
    if (offerings.current != null &&
        (offerings.current?.availablePackages ?? []).isNotEmpty) {
      offerings.current?.availablePackages.first.
    }
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: FutureBuilder(
        future: getOffering(),
        child: ChildConditionBuilder(
          ValueKey('${widget.node.nid} ${widget.loop}'),
          name: NodeType.name(NType.align),
          child: widget.child,
          params: widget.params,
          states: widget.states,
          dataset: widget.dataset,
          forPlay: widget.forPlay,
          loop: widget.loop,
        ),
      ),
    );
  }
}
