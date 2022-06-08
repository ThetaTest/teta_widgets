// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:

class FActionCustomFunctionSimple {
  static Future action(
    final BuildContext context,
    final int? loop,
  ) async {
    const _style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    );
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const Text('Custom Functions'),
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
