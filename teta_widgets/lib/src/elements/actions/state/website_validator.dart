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

class FActionWebsiteValidator {
  static Future action({
    required final BuildContext context,
    required final String? stateName,
    required final String? stateName2,
  }) async {
    if (stateName2 == null) return;
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final index = pageState.states
        .indexWhere((final element) => element.name == stateName);
    if (index >= 0) {
      const pattern =
          r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
      final regExp = RegExp(pattern);
      var value = '';
      if ('${pageState.states[index].value}'.isEmpty) {
        value = 'false';
      } else if (!regExp.hasMatch('${pageState.states[index].value}')) {
        value = 'false';
      } else {
        value = 'true';
      }
      updateStateValue(context, stateName2, value);
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
      const pattern =
          r'(http|https)://[w-]+(.[w-]+)+([w.,@?^=%&amp;:/~+#-]*[w@?^=%&amp;/~+#-])?';
      final regExp = RegExp(pattern);
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
