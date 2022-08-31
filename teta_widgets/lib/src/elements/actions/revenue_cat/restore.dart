// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';
import 'package:universal_platform/universal_platform.dart';

class FActionRevenueCatRestorePurchases {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    if (!UniversalPlatform.isIOS && !UniversalPlatform.isAndroid) {
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
    } else {
      try {
        final restoredInfo = await Purchases.restoreTransactions();
        final index =
            states.indexWhere((final element) => element.name == stateName);
        if (index >= 0) {
          states[index].value =
              restoredInfo.entitlements.active.isEmpty ? 'Success' : 'Failed';
          update(context);
        }
      } on PlatformException catch (e) {
        // Error restoring purchases
        Logger.printError('$e');
      }
    }
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
    final int pageId,
  ) {
    if (stateName == null) return '';

    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    try {
        final restoredInfo = await Purchases.restoreTransactions();
        setState(() {
          $varName = restoredInfo.entitlements.active.isEmpty ? 'Success' : 'Failed';
        });
      } catch (e) {
        // Error restoring purchases
        print('\$e');
      }
    ''';
  }
}
