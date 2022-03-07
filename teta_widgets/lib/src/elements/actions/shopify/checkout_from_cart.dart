// Flutter imports:
/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/utils/shopify/models/models.dart';
import 'package:mobile_editor/src/utils/shopify/shopify/shopify.dart';
import 'package:url_launcher/url_launcher.dart';

class FActionShopifyCheckOutFromCart {
  void makeAction(BuildContext context) async {
    try {
      ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
      String checkoutId = await shopifyCheckout.createCheckout();
      List<String> variantIdList = [];
      try {
        await shopifyCheckout.checkoutLineItemsReplace(
            checkoutId, variantIdList);
        Checkout checkout =
            await shopifyCheckout.getCheckoutInfoQuery(checkoutId);
        print(checkout.webUrl);
        if (await canLaunch(checkout.webUrl!))
          launch(checkout.webUrl!, forceWebView: true);
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  String toCode() {
    return """
      ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
      String checkoutId = await shopifyCheckout.createCheckout();
      List<String> variantIdList = [];
      try {
        await shopifyCheckout.checkoutLineItemsReplace(
            checkoutId, variantIdList);
        Checkout checkout =
            await shopifyCheckout.getCheckoutInfoQuery(checkoutId);
        print(checkout.webUrl);
        if (await canLaunch(checkout.webUrl!))
          launch(checkout.webUrl!, forceWebView: true);
      } catch (e) {
        print(e.toString());
      }
    """;
  }
}
*/
