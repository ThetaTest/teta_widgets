// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

class FActionStateChangeWith {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
    final String? valueToChangeWith,
  ) async {
    try {
      final index =
          states.indexWhere((final element) => element.name == stateName);
      states[index].value = '$valueToChangeWith';
      update(context);
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
    final String? valueToChangeWith,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    final buffer = StringBuffer()..write('');
    if (variable.type == VariableType.string) {
      buffer.write("$varName = '''$valueToChangeWith''';");
    } else {
      if (variable.type == VariableType.int) {
        buffer.write(
          "$varName = ${int.tryParse(valueToChangeWith ?? '') ?? valueToChangeWith};",
        );
      } else if (variable.type == VariableType.double) {
        buffer.write(
          "$varName = ${double.tryParse(valueToChangeWith ?? '') ?? valueToChangeWith};",
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
