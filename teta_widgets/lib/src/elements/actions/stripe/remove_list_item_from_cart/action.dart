import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/teta_widget_state.dart';
import 'params.dart';

//pk_test_51KqdzMGPvMnMI31y86lGM16w4HD9XITvjxuBMiQ7c74Q2lo8g9M94nU2W149XcM0Nb86rzWxik0AdIHsyBuHayqh000Jvu5Te7
//sk_test_51KqdzMGPvMnMI31yeQ2EIzATq6JtLElCHJuWoDp9JC8cxXSpVWZfOdQHdqdCO4Us4nlQYY8cVRx1lisCRk5zU2og00HM2MhVWL
class TAStripeRemoveProductsListItemFromCart extends TetaAction {
  TAStripeRemoveProductsListItemFromCart({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStripeRemoveProductsListItemFromCart.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStripeRemoveProductsListItemFromCartParams.fromJson(
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
  TAStripeRemoveProductsListItemFromCartParams get params =>
      super.params as TAStripeRemoveProductsListItemFromCartParams;

  @override
  TetaActionType get type => TetaActionType.stripeCartRemoveListItem;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    const _style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    );
    //get the dataset --> always called products
    final dataset = state.dataset.firstWhereOrNull(
      (final element) => element.getName == 'products',
    );
    //take the automatic id and loop foreach elements and take the id, this is used for purchase
    final id = dataset!.getMap[state.loop ?? 0]['id'] as String;
    final name = dataset.getMap[state.loop ?? 0]['name'] as String;
    final price = dataset.getMap[state.loop ?? 0]['price'] as int;
    final currency = dataset.getMap[state.loop ?? 0]['currency'] as String;
    final isSubscription =
        dataset.getMap[state.loop ?? 0]['isSubscription'] as bool;
    //await payments(context, value);
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const Text('Stripe Action Purchase'),
          titleTextStyle: _style,
          backgroundColor: const Color(0xFF333333),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 400,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    name,
                    style: _style,
                  ),
                  Text(
                    id,
                    style: _style,
                  ),
                  Text(
                    price.toString(),
                    style: _style,
                  ),
                  Text(
                    currency,
                    style: _style,
                  ),
                  Text(
                    'subscription: ${isSubscription.toString()}',
                    style: _style,
                  ),
                  const Text(
                    'Action: Buy',
                    style: _style,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
      final cart =
      datasets['cart'] as List?;
      if (cart != null &&
          cart.length > index) {
        await TetaCMS.instance.store.cart.delete(cart[index]['id']);
        cart.remove(
          cart.firstWhere(
            (e) => e['id'] == cart[index]['id'],
          ),
        );
        setState((){});
      }
    } catch (e) {
      print(e.toString());
    }
    ''';
  }
}
