// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_param_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class FActionStateChangeWithParam {
  static Future action(
    final BuildContext context,
    final String? stateName,
    final String? paramName,
  ) async {
    if (stateName == null) return;
    if (paramName == null) return;
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final index = pageState.states.indexWhere(
      (final element) => element.name == stateName,
    );
    final indexParam = pageState.params.indexWhere(
      (final element) => element.name == paramName,
    );
    final variable = pageState.states[index].copyWith(
      value: pageState.params[indexParam].value ??
          pageState.params[indexParam].defaultValue,
      controller: pageState.params[index].controller,
      file: pageState.params[index].file,
      webViewController: pageState.params[index].webViewController,
    );
    context.read<PageCubit>().updateState(variable);
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? stateName,
    final String? paramN,
  ) {
    final page = getPageOnToCode(pageId, context);
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
