// Flutter imports:
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:teta_cms/teta_cms.dart';
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
  static const mapTitle = 'RevenueCat Sub Status';
  DatasetObject _map = DatasetObject(
    name: mapTitle,
    map: [<String, dynamic>{}],
  );

  Future<PurchaserInfo?> loadStatus() async {
    try {
      return Purchases.getPurchaserInfo();
    } catch (e) {
      // Error fetching purchaser info
    }
    return null;
  }

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: TetaFutureBuilder<void>(
        future: loadStatus(),
        builder: (final context, final snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final entitlement = widget.entitlementInfo.get(
            widget.params,
            widget.states,
            widget.dataset,
            widget.forPlay,
            widget.loop,
            context,
          );
          final info = snap.data as PurchaserInfo?;
          final map = <String, dynamic>{
            'isActive': info?.entitlements.all[entitlement]?.isActive ?? false,
          };
          _map = _map.copyWith(
            name: mapTitle,
            map: [map],
          );
          final datasets = addDataset(context, widget.dataset, _map);
          if (widget.child != null) {
            return widget.child!.toWidget(
              params: widget.params,
              states: widget.states,
              dataset: widget.dataset.isEmpty ? datasets : widget.dataset,
              forPlay: widget.forPlay,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
