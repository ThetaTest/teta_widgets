import 'package:flutter/material.dart';
import 'package:teta_core/src/utils/stripe/html/stripe_checkout.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TATetaStoreCheckout extends TetaAction {
  TATetaStoreCheckout({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TATetaStoreCheckout.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TATetaStoreCheckoutParams.fromJson(
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
  TATetaStoreCheckoutParams get params =>
      super.params as TATetaStoreCheckoutParams;

  @override
  TetaActionType get type => TetaActionType.tetaStoreCheckout;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
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

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''
    try {
      final index = states.indexWhere((element) => element.name == "${params.stateName}");
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
