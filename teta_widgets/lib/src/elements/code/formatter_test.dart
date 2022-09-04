import 'package:dart_style/dart_style.dart';

class FormatterTest {
  static bool format(final String code) {
    var result = false;
    final formatter = DartFormatter();
    try {
      formatter.format('''
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return $code;
  }
}''');
      result = true;
    } catch (_) {}
    return result;
  }
}
