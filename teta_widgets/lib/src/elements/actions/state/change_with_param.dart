// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_param_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

class FActionStateChangeWithParam {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final List<VariableObject> params,
    final String? stateName,
    final String? paramName,
  ) async {
    try {
      final index = states.indexWhere(
        (final element) => element.name == stateName,
      );
      final indexParam = params.indexWhere(
        (final element) => element.name == paramName,
      );
      states[index].value =
          params[indexParam].value ?? params[indexParam].defaultValue;
      states[index].controller = params[index].controller;
      states[index].file = params[index].file;
      // states[index].audioController = params[index].audioController;
      states[index].webViewController = params[index].webViewController;
      update(context);
    } catch (e) {
      debugPrint('$e');
    }
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? stateName,
    final String? paramN,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, '$stateName');
    final param = takeParamFrom(page, '$paramN');
    if (param == null ||
        stateName == null ||
        variable == null ||
        paramN == null) return '';

    final varName = ReCase(stateName).camelCase;
    final paramName = ReCase(paramN).camelCase;

    final buffer = StringBuffer()..write('');
    if (variable.type == VariableType.string) {
      buffer.write("$varName = '''$paramName''';");
    } else {
      if (variable.type == VariableType.int) {
        buffer.write(
          '$varName = $paramName;',
        );
      } else if (variable.type == VariableType.double) {
        buffer.write(
          '$varName = $paramName;',
        );
      } else {
        return '';
      }
    }

    return '''
    setState(() {
      ${buffer.toString()}
    });
    ''';
  }
}
