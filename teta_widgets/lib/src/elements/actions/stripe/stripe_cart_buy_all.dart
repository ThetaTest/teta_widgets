// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FActionStripeCartBuyAll {
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
    required final String email,
    required final String phone,
    required final String city,
    required final String state,
    required final String line,
    required final String postalCode,
    required final String country,
  }) {
    return '''
                      final purchaseData = (await getPaymentIntent()).data;
                      if(purchaseData != null){
                      Stripe.publishableKey = purchaseData.stripePublishableKey;
                      Stripe.merchantIdentifier = purchaseData.merchantIdentifier;

                      await Stripe.instance.initPaymentSheet(
                          paymentSheetParameters: SetupPaymentSheetParameters(
                        googlePay: PaymentSheetGooglePay(
                          merchantCountryCode: 'IT',
                          testEnv: true,
                        ),
                        applePay: PaymentSheetApplePay(
                          merchantCountryCode: 'IT',
                        ),
                        merchantDisplayName: 'Test',
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
                      }
    ''';
  }
}
