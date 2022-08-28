// Flutter imports:
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:adapty_flutter/models/adapty_paywall.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WAdaptyPaywalls extends StatefulWidget {
  /// Returns a [WAdaptyPaywalls] widget in Teta
  const WAdaptyPaywalls(
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
  State<WAdaptyPaywalls> createState() => _WAdaptyPaywallsState();
}

class _WAdaptyPaywallsState extends State<WAdaptyPaywalls> {
  @override
  void initState() {
    future 
    super.initState();
  }

  Future<dynamic> getPaywalls() async {
    try {
      final getPaywallsResult = await Adapty.getPaywalls();
      final paywalls = getPaywallsResult.paywalls ?? <AdaptyPaywall>[];
      final index = paywalls.indexWhere((final element) => element.developerId == '');
      if (index != -1) {
      await Adapty.showVisualPaywall(paywall: paywalls.firstWhere((final element) => false));
      }
    } catch (e) {}
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
