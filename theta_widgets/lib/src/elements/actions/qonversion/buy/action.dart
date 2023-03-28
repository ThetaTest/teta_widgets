import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:theta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAQonversionBuy extends TetaAction {
  TAQonversionBuy({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAQonversionBuy.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAQonversionBuyParams.fromJson(
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
  TAQonversionBuyParams get params => super.params as TAQonversionBuyParams;

  @override
  TetaActionType get type => TetaActionType.qonversionBuy;

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
          title: TAlertTitle('Qonversion'),
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
              'Qonversion will be activated in your released app.',
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
      final QOfferings offerings = await Qonversion.offerings();
      final List<QProduct> products = offerings.main.products;
      final index = products.indexWhere((prod) => prod.qonversionId == ${params.productIdentifier!.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    )});
      if (index != -1) {
        final Map<String, QPermission> permissions = await Qonversion.purchaseProduct(products[index]);
        setState(() {
          $varName = permissions.entries.isNotEmpty ? 'Success' : 'Failed';
        });
      }
    } catch (e) {
      print('\$e');
    }
    ''';
  }
}
