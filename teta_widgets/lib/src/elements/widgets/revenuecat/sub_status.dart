// Flutter imports:
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:teta_cms/teta_cms.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:teta_models/teta_models.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WRevenueCatSingleSubStatus extends StatefulWidget {
  /// Returns a [WRevenueCatSingleSubStatus] widget in Teta
  const WRevenueCatSingleSubStatus(
    final Key? key, {
    required this.state,
    required this.entitlementInfo,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput entitlementInfo;

  @override
  State<WRevenueCatSingleSubStatus> createState() =>
      _WRevenueCatSingleSubStatusState();
}

class _WRevenueCatSingleSubStatusState
    extends State<WRevenueCatSingleSubStatus> {
  static const mapTitle = 'RevenueCat Sub Status';
  DatasetObject _map = const DatasetObject(
    name: mapTitle,
    map: [<String, dynamic>{}],
  );

  Future<bool> loadStatus() async {
    if (UniversalPlatform.isAndroid) {
      try {
        final entitlement = widget.entitlementInfo.get(
          widget.state.params,
          widget.state.states,
          widget.state.dataset,
          widget.state.forPlay,
          widget.state.loop,
          context,
        );
        final res = await Purchases.getPurchaserInfo();
        return res.entitlements.all[entitlement]?.isActive ?? false;
      } catch (e) {
        // Error fetching purchaser info
      }
    }
    return false;
  }

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: TetaFutureBuilder<bool>(
        future: loadStatus(),
        builder: (final context, final snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final isActive = snap.data ?? false;
          final map = <String, dynamic>{
            'isActive': isActive,
          };
          _map = _map.copyWith(
            name: mapTitle,
            map: [map],
          );
          final datasets = addDataset(context, _map);
          if (widget.child != null) {
            return widget.child!.toWidget(
              state: widget.state.copyWith(
                dataset: widget.state.dataset.isEmpty
                    ? datasets
                    : widget.state.dataset,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
