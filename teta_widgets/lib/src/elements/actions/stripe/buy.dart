// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:url_launcher/url_launcher.dart';

//pk_test_51KqdzMGPvMnMI31y86lGM16w4HD9XITvjxuBMiQ7c74Q2lo8g9M94nU2W149XcM0Nb86rzWxik0AdIHsyBuHayqh000Jvu5Te7
//sk_test_51KqdzMGPvMnMI31yeQ2EIzATq6JtLElCHJuWoDp9JC8cxXSpVWZfOdQHdqdCO4Us4nlQYY8cVRx1lisCRk5zU2og00HM2MhVWL
class FActionStripeBuy {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final List<DatasetObject> datasets,
    final int? loop,
  ) async {
    const _style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    );
    //get the dataset --> always called products
    final dataset = datasets
        .firstWhereOrNull((final element) => element.getName == 'products');
    //take the automatic id and loop foreach elements and take the id, this is used for purchase
    final id = dataset!.getMap[loop ?? 0]['id'] as String;
    final name = dataset.getMap[loop ?? 0]['name'] as String;
    final price = dataset.getMap[loop ?? 0]['price'] as int;
    final currency = dataset.getMap[loop ?? 0]['currency'] as String;
    final isSubscription = dataset.getMap[loop ?? 0]['isSubscription'] as bool;
    //await payments(context, value);
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const Text('Stripe Action Purchase'),
          titleTextStyle: _style,
          backgroundColor: const Color(0xFF333333),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 400,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    name,
                    style: _style,
                  ),
                  Text(
                    id,
                    style: _style,
                  ),
                  Text(
                    price.toString(),
                    style: _style,
                  ),
                  Text(
                    currency,
                    style: _style,
                  ),
                  Text(
                    'subscription: ${isSubscription.toString()}',
                    style: _style,
                  ),
                  const Text(
                    'Action: Buy',
                    style: _style,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //todo: this code is very fragile, review
  static String toCode(
    final BuildContext context,
    final String? stateName,
    final CNode body,
  ) {
    final prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    return '''
    
    final dataset = datasets['products'][index];
                                
    Map<String, dynamic> body = {
      'amount': dataset['price'].toString(),
      'currency': dataset['currency'].toString(),
    };
                                
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${prj.config!.stripePrivateKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      Map<String, dynamic>? paymentIntentData = jsonDecode(response.body);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: '${prj.config!.stripePublicKey}')).then((value){
      });
      try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData['client_secret'],
            confirmPayment: true,
          )).then((newValue){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));
        paymentIntentData = null;
      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET on StripeException catch');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print(e.toString());
    }
    ''';
  }
}
