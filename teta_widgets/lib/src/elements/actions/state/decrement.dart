// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

class FActionStateDecrement {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    try {
      final index =
          states.indexWhere((final element) => element.name == stateName);
      if (double.tryParse('${states[index].get}') != null) {
        final value = double.parse('${states[index].get}');
        states[index].value = '${value - 1}';
      }
      update(context);
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
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

    if (variable.type == VariableType.string) {
      return '''
    if (double.tryParse($varName) != null) { 
      setState(() {
        $varName = '\${double.parse($varName) - 1}';
      });
    }''';
    } else if (variable.type == VariableType.int) {
      return '''
    if (int.tryParse($varName) != null) { 
      setState(() {
        $varName--';
      });
    }''';
    } else if (variable.type == VariableType.double) {
      return '''
    if (double.tryParse($varName) != null) { 
      setState(() {
        $varName--';
      });
    }''';
    } else {
      return '';
    }
  }
}
