// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:teta_cms/teta_cms.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:theta_models/theta_models.dart';

class FActionTetaStoreCartBuyAll {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final List<DatasetObject> datasets,
    final int? loop, {
    required final String email,
    required final String phone,
    required final String city,
    required final String state,
    required final String line,
    required final String postalCode,
    required final String country,
    required final String shippingId,
  }) async {
    /*
    final res = await TetaCMS.I.store.cart.getPaymentIntent(
      shippingId,
      UserAddress(
        email: email,
        phone: phone,
        city: city,
        state: state,
        line: line,
        postalCode: postalCode,
        country: country,
      ),
    );
    final purchaseData = res.data;

    final settings = (await TetaCMS.I.store.getSettings()).data!;

    if (purchaseData != null) {
      Stripe.publishableKey = purchaseData.stripePublishableKey;
      Stripe.merchantIdentifier = purchaseData.merchantIdentifier;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: settings.merchantDisplayName,
          billingDetails: BillingDetails(
            email: email,
            phone: phone,
            address: Address(
              city: city,
              state: state,
              line2: '',
              line1: line,
              postalCode: postalCode,
              country: country,
            ),
            name: email,
          ),
          paymentIntentClientSecret: purchaseData.paymentIntentClientSecret,
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      await TetaCMS.instance.store.checkPayment(purchaseData.paymentIntent);
    }*/
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
    final CNode body, {
    required final String email,
    required final String phone,
    required final String city,
    required final String state,
    required final String line,
    required final String postalCode,
    required final String country,
    required final String shippingId,
  }) {
    return '''
    final res = await TetaCMS.instance.store.cart.getPaymentIntent(
      $shippingId,
      UserAddress(
        email: $email,
        phone: $phone,
        city: $city,
        state: $state,
        line: $line,
        postalCode: $postalCode,
        country: $country,
      ),
    );
    final purchaseData = res.data;

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
        email: $email,
        phone: $phone,
        address: Address(
          city: $city,
          state: $state,
          line2: '',
          line1: $line,
          postalCode: $postalCode,
          country: $country,
        ),
        name: $email,
      ),
      paymentIntentClientSecret: purchaseData.paymentIntentClientSecret,
    ));

    await Stripe.instance.presentPaymentSheet();
    
    await TetaCMS.instance.store.checkPayment(purchaseData.paymentIntent);
    }
    ''';
  }
}
