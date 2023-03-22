// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_models/teta_models.dart';

class FActionEmailValidator {
  static Future action({
    required final BuildContext context,
    required final List<VariableObject> states,
    required final String? stateName,
    required final String? stateName2,
  }) async {
    final index =
        states.indexWhere((final element) => element.name == stateName);
    if (index >= 0) {
      const pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      final regex = RegExp(pattern);
      updateStateValue(
        context,
        stateName2!,
        '${!regex.hasMatch('${states[index].get}')}',
      );
    }
  }

  static String toCode({
    required final int pageId,
    required final BuildContext context,
    required final String? stateName,
    required final String? stateName2,
    final int loop = 0,
  }) {
    if (stateName == null || stateName2 == null) {
      return '';
    }
    final page = getPageOnToCode(pageId, context);
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    final variable2 = takeStateFrom(page, stateName2);
    if (variable2 == null) return '';

    final varName2 = ReCase(stateName2).camelCase;

    const regex = r'''
const pattern =
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
        final regex = RegExp(pattern);
''';
    return '''
      $regex
      if (!regExp.hasMatch('\$$varName')) {
        setState(() {
          $varName2 = 'false';
        });
      } else {
        setState(() {
          $varName2 = 'true';
        });
      }
    ''';
  }
}
