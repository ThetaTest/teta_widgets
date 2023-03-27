import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TAStripeShowReceipt extends TetaAction {
  TAStripeShowReceipt({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStripeShowReceipt.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStripeShowReceiptParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TAStripeShowReceiptParams get params =>
      super.params as TAStripeShowReceiptParams;

  @override
  TetaActionType get type => TetaActionType.stripeShowReceipt;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {}

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''
     await launchUrl(
      Uri.parse(
        (await TetaCMS.instance.store.getReceiptLink(
              ${params.paymentIntentId},
            )).data ?? '',
      ),
    );
    ''';
  }
}
