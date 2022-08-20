// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

class FActionPhoneValidator {
  static Future action({
    required final BuildContext context,
    required final List<VariableObject> states,
    required final String? stateName,
    required final String? stateName2,
  }) async {
    try {
      final index =
          states.indexWhere((final element) => element.name == stateName);
      final index2 =
          states.indexWhere((final element) => element.name == stateName2);
      if (index >= 0 && index2 >= 0) {
        const patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        final regExp = RegExp(patttern);
        if ('${states[index].value}'.isEmpty) {
          states[index2].value = 'false';
        } else if (!regExp.hasMatch('${states[index].value}')) {
          states[index2].value = 'false';
        } else {
          states[index2].value = 'true';
        }
        update(context);
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  static String toCode({
    required final int pageId,
    required final BuildContext context,
    required final String? stateName,
    required final String? stateName2,
  }) {
    if (stateName == null || stateName2 == null) {
      return '';
    }
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    final variable2 = takeStateFrom(page, stateName2);
    if (variable2 == null) return '';

    final varName2 = ReCase(stateName2).camelCase;

    return '''
      const patttern = r'(^(?:[+0]9)?[0-9]{10,12}\$)';
      final regExp = RegExp(patttern);
      if ('\$$varName'.isEmpty) {
        setState(() {
          $varName2 = 'false';
        });
      } else if (!regExp.hasMatch('\$$varName')) {
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
