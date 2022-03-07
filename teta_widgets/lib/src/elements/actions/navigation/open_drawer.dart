// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

class FActionNavigationOpenDrawer {
  static Future action(BuildContext context) async {
    if (!Scaffold.of(context).isDrawerOpen) Scaffold.of(context).openDrawer();
  }

  static String toCode() {
    return '''
    if (!Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).openDrawer();
    }
    ''';
  }
}
