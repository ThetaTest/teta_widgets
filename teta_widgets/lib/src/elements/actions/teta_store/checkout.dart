// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/src/utils/stripe/html/stripe_checkout.dart';

class FActionTetaStoreCheckout {
  Future makeAction(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    const apiKey =
        // ignore: lines_longer_than_80_chars
        'pk_test_51HvjcTKxqQXfudIUiQyzcNY3z5Qs9RgDXKc7lZ8lvQysMYjFYBtbIXHhOhSh3vFM0Ew1TZDFKYdNhdQzi36gqAyV00oem6BUN4';
    Stripe(apiKey).redirectToCheckout(
      CheckoutOptions(
        lineItems: [
          LineItem(
            price: 'someIdOftheProductFromStripeDashboard',
            quantity: 1,
          )
        ],
        mode: 'payment',
        successUrl: 'http://localhost:8080/#/success',
        cancelUrl: 'http://localhost:8080/#/cancel',
      ),
    );
  }

  String toCode(final BuildContext context, final String? stateName) {
    return '''
    try {
      final index = states.indexWhere((element) => element.name == "$stateName");
      if (double.tryParse(states[index].value ?? states[index].defaultValue) !=
          null) {
        final value =
            double.parse(states[index].value ?? states[index].defaultValue) + 1;
        states[index].value = value.toString();
        BlocProvider.of<StatesCubit>(context).update(states[index]);
      }
    } catch (e) {
      print(e);
    }
    ''';
  }
}
