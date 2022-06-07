// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';

class FActionCustomFunctionSimple {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final List<DatasetObject> datasets,
    final int? loop,
  ) async {
    const _style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    );
    //await payments(context, value);
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const Text('CustomFucntion'),
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
                children: const [
                  Text(
                    'Runned',
                    style: _style,
                  ),
                  Text(
                    'CustomFunction',
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

  static String toCode(
    final BuildContext context,
  ) {
    return '''
      print('hello world');
    ''';
  }
}
