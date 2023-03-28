// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_models/theta_models.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WQonversionSingleSubStatus extends StatefulWidget {
  /// Returns a [WQonversionSingleSubStatus] widget in Teta
  const WQonversionSingleSubStatus(
    final Key? key, {
    required this.state,
    required this.entitlementInfo,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput entitlementInfo;

  @override
  State<WQonversionSingleSubStatus> createState() =>
      _WQonversionSingleSubStatusState();
}

class _WQonversionSingleSubStatusState
    extends State<WQonversionSingleSubStatus> {
  static const mapTitle = 'Qonversion Sub Status';
  DatasetObject _map = const DatasetObject(
    name: mapTitle,
    map: [<String, dynamic>{}],
  );

  Future<bool> loadStatus() async {
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
            ));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
