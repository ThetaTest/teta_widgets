// Flutter imports:
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WQRScanner extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WQRScanner(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
        child: MobileScanner(
          onDetect: (final barcode, final args) async {
            if (barcode.rawValue == null) {
            } else {
              final code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
              if (await canLaunchUrlString(code)) {
                await launchUrlString(code);
              }
            }
          },
        ),
      ),
    );
  }
}