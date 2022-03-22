// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';

class FActionRevenueCatBuy {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return const AlertDialog(
          title: TAlertTitle('RevenueCat'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          backgroundColor: Color(0xFF333333),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 400,
            height: 400,
            child: Text(
              'Revenue cat will be activated in your released app.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  static String toCode(final BuildContext context, final String? stateName) {
    return '''
    try {
      PurchaserInfo purchaserInfo = await Purchases.purchaseProduct('$stateName');
      //here we have the purchaseInfo response
      try{
        final isPro = purchaserInfo.entitlements.all["my_entitlement_identifier"]!.isActive;
        if (isPro) {
           // Unlock that great "pro" content
         }
        } catch (e){
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        await showDialog<void>(
          context: context,
          builder: (context) => Text(
            e.toString(),
          ),
        );
      }
    }
    ''';
  }
}
