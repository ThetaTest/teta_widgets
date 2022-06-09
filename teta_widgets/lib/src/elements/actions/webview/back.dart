// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

class FActionWebViewBack {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    final variable =
        states.firstWhereOrNull((final element) => element.name == stateName);
    if (variable?.webViewController != null) {
      final flag = await variable?.webViewController?.canGoBack();
      if (flag ?? false) {
        await variable?.webViewController?.goBack();
      }
    }
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? stateName,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    if ($varName != null) { 
      final flag = await $varName.canGoBack();
      if (flag ?? false) {
      $varName.goBack();
      }
    }''';
  }
}
