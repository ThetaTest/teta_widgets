// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:collection/collection.dart';
import 'package:teta_core/teta_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

class FActionStripeBuy {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final List<DatasetObject> datasets,
    final int? loop,
  ) async {
    //todo: fare qui il get del nome del dataset dinamico
    final dataset = datasets
        .firstWhereOrNull((final element) => element.getName == 'products');
    final value = dataset!.getMap[loop ?? 0]['id'] as String;
    await payments(context, value);
    // await showDialog<void>(
    //   context: context,
    //   builder: (final context) {
    //     return  AlertDialog(
    //       title: Text('Stripe Buy'),
    //       titleTextStyle: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Colors.white,
    //         fontSize: 20,
    //       ),
    //       backgroundColor: Color(0xFF333333),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(20)),
    //       ),
    //       content: SizedBox(
    //         width: 400,
    //         height: 400,
    //         child: SingleChildScrollView(
    //           child: Text(
    //             value,
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  //todo: concludere questo
  static String toCode(final BuildContext context, final String? stateName) {
    return '''
   
    ''';
  }

  static Future payments(
      final BuildContext context, final String productId) async {
    ProjectObject prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    final baseUrl =
        'https://builder.teta.so:8402/portal/${prj.id}/$productId/pay';
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'stripe-api-key': prj.config!.stripePrivateKey!,
      },
    );

    if (response.statusCode == 200) {
      debugPrint('payment response: ${response.body}');
      await launch(response.body);
      //todo: questo va nel tocode
      //  await  Navigator.of(context).push(MaterialPageRoute<Widget>(builder: (final _) {
      //     return WebViewX(
      //       width: 300,
      //       height: 300,
      //       initialContent: response.body,
      //        initialSourceType: SourceType.urlBypass,
      //   userAgent:
      //       'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36 OPR/80.0.4170.63',
      //   onWebResourceError: (final err) => debugPrint('Error$err'),


    //     );
    //   },),);
    }

    if (response.statusCode != 200) {
      debugPrint('payment error: ${response.body}');
    }
  }
}
