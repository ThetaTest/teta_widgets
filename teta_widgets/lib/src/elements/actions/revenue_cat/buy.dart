// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FActionRevenueCatBuy {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final FTextTypeInput? productIdentifier,
    final String? stateName,
  ) async {
    if (productIdentifier == null) return;
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

  static String toCode(
    final BuildContext context,
    final FTextTypeInput? productIdentifier,
    final String? stateName,
    final int pageId,
    final int loop,
  ) {
    if (productIdentifier == null || stateName == null) {
      return '';
    }

    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    try {
      final purchaserInfo = await Purchases.purchaseProduct(${productIdentifier.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    )});
      setState(() {
        $varName = purchaserInfo.entitlements.active.isEmpty ? 'Success' : 'Failed';
      });
    } catch (e) {
      print('\$e');
    }
    ''';
  }
}
