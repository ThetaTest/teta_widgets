// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

class FActionNavigationGoBack {
  static Future action(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  static String toCode() {
    return '''Navigator.of(context, rootNavigator: true).pop(null);''';
  }
}
