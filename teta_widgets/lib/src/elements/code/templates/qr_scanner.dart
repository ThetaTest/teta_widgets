// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:

/// Generates the code for Align widget
class QRScannerCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
  ) async {
    const code = '''
    MobileScanner(
      onDetect: (final barcode, final args) async {
        if (barcode.rawValue == null) return;
        final code = barcode.rawValue!;
        if (await canLaunchUrlString(code)) {
          await launchUrlString(code);
        }
      },
    )
  ''';
    final result = FormatterTest.format(code);
    if (result) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'Align';
    final codeToRun = await toCode(
      context,
    );
    final returnValue = FormatterTest.format(
      codeToRun,
    );
    if (!returnValue) {
      Logger.printError(
        'Runtime ToCode Default Error:\n$name\nThis was the code:\n',
      );
      Logger.printWarning(codeToRun);
      Logger.printMessage('\n-----------END-----------');
    } else {
      Logger.printSuccess('$name: Passed!');
    }
    return returnValue;
  }
}
