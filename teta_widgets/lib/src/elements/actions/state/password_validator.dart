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
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FActionPasswordValidator {
  static Future action({
    required final BuildContext context,
    required final String? stateName,
    required final String? stateName2,
  }) async {
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final index = pageState.states
        .indexWhere((final element) => element.name == stateName);
    if (index >= 0) {
      final numReg = RegExp('.*[0-9].*');
      final letterReg = RegExp('.*[A-Za-z].*');
      var value = '';
      if ('${pageState.states[index].value}'.isEmpty) {
        value = 'Please enter you password';
      } else if ('${pageState.states[index].value}'.length < 6) {
        value = 'Your password is too short';
      } else if ('${pageState.states[index].value}'.length < 8) {
        value = 'Your password is acceptable but not strong';
      } else {
        if (!letterReg.hasMatch('${pageState.states[index].value}') ||
            !numReg.hasMatch('${pageState.states[index].value}')) {
          value = 'Your password is strong';
        } else {
          value = 'Your password is great';
        }
      }
      updateStateValue(
        context,
        stateName2!,
        value,
      );
      return;
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
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    final variable2 = takeStateFrom(page, stateName2);
    if (variable2 == null) return '';

    final varName2 = ReCase(stateName2).camelCase;

    return '''
      final numReg = RegExp('.*[0-9].*');
      final letterReg = RegExp('.*[A-Za-z].*');
      if ('\$$varName'.isEmpty) {
        $varName2 = 'Please enter you password';
      } else if ('\$$varName'.length < 6) {
        $varName2 = 'Your password is too short';
      } else if ('\$$varName'.length < 8) {
        $varName2 = 'Your password is acceptable but not strong';
      } else {
        if (!letterReg.hasMatch('\$$varName') ||
            !numReg.hasMatch('\$$varName')) {
          $varName2 = 'Your password is strong';
        } else {
          $varName2 = 'Your password is great';
        }
      }
    ''';
  }
}
