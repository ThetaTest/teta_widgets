// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

class FActionStateDecrement {
  static Future action(
    BuildContext context,
    List<VariableObject> states,
    String? stateName,
  ) async {
    try {
      final index = states.indexWhere((element) => element.name == stateName);
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

  static String toCode(BuildContext context, String? stateName) {
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
