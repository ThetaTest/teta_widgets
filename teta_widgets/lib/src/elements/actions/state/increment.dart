// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

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
        states[index].value = '${value + 1}';
      }
      update(context);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static String toCode(final BuildContext context, final String? stateName) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    if (double.tryParse($varName) != null) { 
      setState(() {
        $varName = '\${double.parse($varName) - 1}';
      });
    }''';
  }
}
