// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class FActionStateDecrement {
  static Future action(
    final BuildContext context,
    final String? stateName,
  ) async {
    if (stateName == null) return;
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final index = pageState.states
        .indexWhere((final element) => element.name == stateName);
    if (double.tryParse('${pageState.states[index].get}') != null) {
      final value = double.parse('${pageState.states[index].get}');
      updateStateValue(context, stateName, value);
    }
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? stateName,
  ) {
    final page = getPageOnToCode(pageId, context);
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
