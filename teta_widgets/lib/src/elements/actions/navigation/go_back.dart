// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

class FActionNavigationGoBack {
  //todo: BUG ---> find a way to adjust this code
  //? actual behaviour: now stops the play mode and pop the context (of the editor)
  //? wanted behaviour: go back on the precedent page (on the play mode app running)
  static Future action(final BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  static String toCode() {
    return '''Navigator.of(context, rootNavigator: true).pop(null);''';
  }
}
