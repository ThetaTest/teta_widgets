// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:collection/collection.dart';

class FActionStripeBuy {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final List<DatasetObject> datasets,
  ) async {
    //todo: fare qui il get del nome del dataset dinamico
    final dataset = datasets.firstWhereOrNull((final element) => element.getName == 'products');
    
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return  AlertDialog(
          title: Text('Stripe Buy'),
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
            child: SingleChildScrollView(
              child: Text(
                dataset.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  //todo: concludere questo
  static String toCode(final BuildContext context, final String? stateName) {
    return '''
   
    ''';
  }
}
