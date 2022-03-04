// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_param_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

class FActionStateChangeWithParam {
  static Future action(
    BuildContext context,
    List<VariableObject> states,
    List<VariableObject> params,
    String? stateName,
    String? paramName,
  ) async {
    try {
      final index = states.indexWhere(
        (element) => element.name == stateName,
      );
      final indexParam = params.indexWhere(
        (element) => element.name == paramName,
      );
      states[index].value =
          params[indexParam].value ?? params[indexParam].defaultValue;
      states[index].controller = params[index].controller;
      states[index].file = params[index].file;
      states[index].audioController = params[index].audioController;
      states[index].webViewController = params[index].webViewController;
      update(context);
    } catch (e) {
      debugPrint('$e');
    }
  }

  static String toCode(
    BuildContext context,
    String? stateName,
    String? paramN,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
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
