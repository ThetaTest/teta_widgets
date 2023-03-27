import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

//pk_test_51KqdzMGPvMnMI31y86lGM16w4HD9XITvjxuBMiQ7c74Q2lo8g9M94nU2W149XcM0Nb86rzWxik0AdIHsyBuHayqh000Jvu5Te7
//sk_test_51KqdzMGPvMnMI31yeQ2EIzATq6JtLElCHJuWoDp9JC8cxXSpVWZfOdQHdqdCO4Us4nlQYY8cVRx1lisCRk5zU2og00HM2MhVWL
class TAStripeAddProductsListItemToCart extends TetaAction {
  TAStripeAddProductsListItemToCart({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStripeAddProductsListItemToCart.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TAStripeAddProductsListItemToCartParams(),
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
  TAStripeAddProductsListItemToCartParams get params =>
      super.params as TAStripeAddProductsListItemToCartParams;

  @override
  TetaActionType get type => TetaActionType.stripeAddListItemToCart;

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
    final id = dataset!.getMap[state.loop ?? 0]['_id'] as String;
    // TODO(andrei): create a special add to cart button that will transform into a minus sign or change text to remove from cart if the item is in cart
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''
    try {
      final products = this
          .datasets['products'] as List?;
      if (products != null &&
          products.length > index) {
      await TetaCMS.instance.store.cart.insert(products[index]['_id']);
      }
    } catch (e) {
      print(e.toString());
    }
    ''';
  }
}
