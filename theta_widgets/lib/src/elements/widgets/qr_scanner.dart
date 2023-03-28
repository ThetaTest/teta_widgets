// Flutter imports:
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WQRScanner extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WQRScanner(
    final Key? key, {
    required this.state,
  }) : super(key: key);

  final TetaWidgetState state;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
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
    );
  }
}
