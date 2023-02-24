// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FActionTetaStoreShowReceipt {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final List<DatasetObject> datasets,
    final int? loop,
  ) async {}

  static String toCode(
    final BuildContext context,
    final String? stateName,
    final CNode body, {
    required final String paymentIntentId,
  }) {
    return '''
     await launchUrl(
      Uri.parse(
        (await TetaCMS.instance.store.getReceiptLink(
              $paymentIntentId,
            ))
                .data ??
            '',
      ),
    );
    ''';
  }
}
