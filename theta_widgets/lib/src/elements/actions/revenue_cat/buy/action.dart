import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TARevenueCatBuy extends TetaAction {
  TARevenueCatBuy({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TARevenueCatBuy.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TARevenueCatBuyParams.fromJson(
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
  TARevenueCatBuyParams get params => super.params as TARevenueCatBuyParams;

  @override
  TetaActionType get type => TetaActionType.revenueCatBuy;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.productIdentifier == null) return;
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

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    if (params.productIdentifier == null || params.stateName == null) {
      return '';
    }

    final page = getPageOnToCode(pageId, context);
    final variable = takeStateFrom(page, params.stateName!);
    if (variable == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    return '''
    try {
      final purchaserInfo = await Purchases.purchaseProduct(${params.productIdentifier!.toCode(
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
