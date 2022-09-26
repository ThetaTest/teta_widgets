// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';

class FActionBraintreeBuy {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
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

  static String toCode(
    final BuildContext context,
    final int pageId,
    final FTextTypeInput? valueToChangeWith,
    final String? stateName, {
    final int loop = 0,
  }) {
    final prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    final isSandbox = prj.config?.braintreeIsSandbox ?? true;
    final token = !isSandbox
        ? prj.config?.braintreeClientToken
        : prj.config?.braintreeClientTokenSandbox;
    final companyName = prj.config?.companyName ?? '';
    final currencyCode = prj.config?.braintreeCurrencyCode ?? '';
    final countryCode = prj.config?.countryCode ?? '';
    final amount = valueToChangeWith!.toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1.00',
    );
    final appleMerchantId = prj.config?.appleMerchantId;
    String? paypal;
    String? googlePay;
    String? applePay;

    if (stateName == null) return '';
    if (amount.isEmpty) return '';

    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    paypal = '''
      BraintreePayPalRequest(
        amount: '$amount',
        displayName: '$companyName',
      ),''';

    if (prj.config?.googlePayFlag ?? false) {
      googlePay = '''
        BraintreeGooglePaymentRequest(
          totalPrice: $amount,
          currencyCode: '$currencyCode',
          billingAddressRequired: false,
        ),''';
    }
    if (prj.config?.isApplePayReady ?? false) {
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
