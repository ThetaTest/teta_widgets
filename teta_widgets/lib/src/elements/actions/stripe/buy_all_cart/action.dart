import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TAStripeBuyAllCart extends TetaAction {
  TAStripeBuyAllCart({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStripeBuyAllCart.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStripeBuyAllCartParams.fromJson(
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
  TAStripeBuyAllCartParams get params =>
      super.params as TAStripeBuyAllCartParams;

  @override
  TetaActionType get type => TetaActionType.stripeCartBuyAll;

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
    final purchaseData = (await TetaCMS.instance.store.cart.getPaymentIntent(
      ${params.shippingId},
      UserAddress(
        email: ${params.email},
        phone: ${params.phone},
        city: ${params.city},
        state: ${params.state},
        line: ${params.line},
        postalCode: ${params.postalCode},
        country: ${params.country},
      ),
    )).data;

    final settings = (await TetaCMS.instance.store.getSettings()).data!;

    if(purchaseData != null){
    Stripe.publishableKey = purchaseData.stripePublishableKey;
    Stripe.merchantIdentifier = purchaseData.merchantIdentifier;

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      googlePay: PaymentSheetGooglePay(
        merchantCountryCode: settings.merchantCountryCode,
        testEnv: !settings.livemode,
      ),
      applePay: PaymentSheetApplePay(
        merchantCountryCode: settings.merchantCountryCode,
      ),
      merchantDisplayName: settings.merchantDisplayName,
      billingDetails: BillingDetails(
        email: ${params.email},
        phone: ${params.phone},
        address: Address(
          city: ${params.city},
          state: ${params.state},
          line2: '',
          line1: ${params.line},
          postalCode: ${params.postalCode},
          country: ${params.country},
        ),
        name: ${params.email},
      ),
      paymentIntentClientSecret: purchaseData.paymentIntentClientSecret,
    ));

    await Stripe.instance.presentPaymentSheet();
    
    await TetaCMS.instance.store.checkPayment(purchaseData.paymentIntent);
    }
    ''';
  }
}
