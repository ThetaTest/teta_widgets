// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';

class FActionStateIncrement {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    try {
      final index =
          states.indexWhere((final element) => element.name == stateName);
      if (double.tryParse(
            states[index].value as String? ?? states[index].defaultValue!,
          ) !=
          null) {
        final value = double.parse(
          states[index].value as String? ?? states[index].defaultValue!,
        );
        updateStateValue(
          context,
          stateName!,
          '${value + 1}',
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
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

    if (variable.type == VariableType.string) {
      return '''
    if (double.tryParse($varName) != null) { 
      setState(() {
        $varName = '\${double.parse($varName) + 1}';
      });
    }''';
    } else if (variable.type == VariableType.int) {
      return '''
    if (int.tryParse($varName) != null) { 
      setState(() {
        $varName++';
      });
    }''';
    } else if (variable.type == VariableType.double) {
      return '''
    if (double.tryParse($varName) != null) { 
      setState(() {
        $varName++';
      });
    }''';
    } else {
      return '';
    }
  }
}
