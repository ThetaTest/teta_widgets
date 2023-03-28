import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TABraintreeBuy extends TetaAction {
  TABraintreeBuy({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TABraintreeBuy.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TABraintreeBuyParams.fromJson(
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
  TABraintreeBuyParams get params => super.params as TABraintreeBuyParams;

  @override
  TetaActionType get type => TetaActionType.braintreeBuy;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const TAlertTitle('Braintree'),
          backgroundColor: Palette.bgDialog,
          content: const TParagraph(
            'Braintree will be activated in your released app.',
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
    final configCubit = BlocProvider.of<ConfigCubit>(context);
    final config = (configCubit.state as ConfigStateLoaded).config;
    final isSandbox = config.braintree.isSandbox;
    final token = !isSandbox
        ? config.braintree.productionInfo.clientToken
        : config.braintree.sandboxInfo.clientToken;
    final companyName = config.braintree.companyName;
    final currencyCode = config.braintree.currencyCode;
    final countryCode = config.braintree.countryCode;
    final amount = params.valueToChangeWith!.toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1.00',
    );
    final appleMerchantId = config.braintree.applePay.merchantId;
    String? paypal;
    String? googlePay;
    String? applePay;

    if (params.stateName == null) return '';
    if (amount.isEmpty) return '';

    final page = getPageOnToCode(pageId, context);
    if (params.stateName == null) return '';
    final variable = takeStateFrom(page, params.stateName!);
    if (variable == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    paypal = '''
      BraintreePayPalRequest(
        amount: '$amount',
        displayName: '$companyName',
      ),''';

    if (config.braintree.googlePay.isEnabled) {
      googlePay = '''
        BraintreeGooglePaymentRequest(
          totalPrice: $amount,
          currencyCode: '$currencyCode',
          billingAddressRequired: false,
        ),''';
    }
    if (config.braintree.applePay.isEnabled) {
      applePay = '''
        BraintreeApplePayRequest(
          displayName: '$companyName',
          paymentSummaryItems: <ApplePaySummaryItem>[
            ApplePaySummaryItem(
                label: '$companyName',
                amount: double.parse($amount),
                type: ApplePaySummaryItemType.Final),
          ],
          currencyCode: '$currencyCode',
          countryCode: '$countryCode',
          appleMerchantID: '$appleMerchantId',
        ),''';
    }

    return '''
    if (UniversalPlatform.isWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payments are not yet supported on web.'),
        ),
      );
      return;
    }
    setState(() {
      $varName = 'Loading';
    });
    final request = BraintreeDropInRequest(
      clientToken: '$token',
      collectDeviceData: true,
      ${googlePay != null ? 'googlePaymentRequest: $googlePay' : ''}
      ${applePay != null ? 'applePayRequest: $applePay' : ''}
      paypalRequest: $paypal
    );
    final result = await BraintreeDropIn.start(request);
    if (result != null) {
      final resp = await TetaCMS.instance.utils.braintreePay(
        result.paymentMethodNonce.nonce,
        result.deviceData,
        $amount,
      );
      if (resp.error == null && resp.data == true) {
        // Success
        setState(() {
          $varName = 'Success';
        });
        return;
      }
    }
    // Failed
    setState(() {
      $varName = 'Failed';
    });
    ''';
  }
}
