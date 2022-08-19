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

class FActionBraintreeBuy {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return const AlertDialog(
          title: TAlertTitle('Braintree'),
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
              'Braintree will be activated in your released app.',
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
    final int pageId,
    final String? stateName,
  ) {
    final prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    final token = prj.config?.braintreeClientToken;
    const companyName = '';
    const currencyCode = '';
    const countryCode = '';
    const amount = '4.20';
    const appleMerchantId = '';
    String? paypal;
    String? googlePay;
    String? applePay;

    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName!);
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
          totalPrice: '$amount',
          currencyCode: 'USD',
          billingAddressRequired: false,
        ),''';
    }
    if (prj.config?.isApplePayReady ?? false) {
      applePay = '''
        BraintreeApplePayRequest(
          displayName: 'Example company',
          paymentSummaryItems: <ApplePaySummaryItem>[
            ApplePaySummaryItem(
                label: '$companyName',
                amount: $amount,
                type: ApplePaySummaryItemType.final_),
          ],
          currencyCode: '$currencyCode',
          countryCode: '$countryCode',
          merchantIdentifier: '$appleMerchantId',
        ),''';
    }

    return '''
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payments are not yet supported on web.'),
        ),
      );
      return;
    }
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
        amount,
      );
      if (resp.error == null && resp.data == true) {
        // Success
        setState(() {
          $varName = 'Success';
        });
      } else {
        // Failed
        setState(() {
          $varName = 'Failed';
        });
      }
    }
    ''';
  }
}
