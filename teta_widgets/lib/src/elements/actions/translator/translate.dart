// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

class FActionTranslatorTranslate {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    final index =
        states.indexWhere((final element) => element.name == stateName);
    if (index != -1) {
      BlocProvider.of<TranslatorGeneratorCubit>(context)
          .state
          .translate(states[index].get as String? ?? 'en');
    }
  }

  static String toCode(
    final BuildContext context,
    final int pageId,
    final String? stateName,
  ) {
    if (stateName == null) return '';

    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    TranslatorGenerator.instance.translate($varName);
    ''';
  }
}
