import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAStripeShowReceiptParams extends TetaActionParams {
  const TAStripeShowReceiptParams({
    required this.paymentIntentId,
  });

  const TAStripeShowReceiptParams.empty() : paymentIntentId = null;

  TAStripeShowReceiptParams.fromJson(final Map<String, dynamic> json)
      : paymentIntentId = json['stripePaymentIntentId'] as String?;

  final String? paymentIntentId;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'stripePaymentIntentId': paymentIntentId,
      };
}
