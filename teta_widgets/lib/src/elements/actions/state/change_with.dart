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
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class FActionStateChangeWith {
  static Future action({
    required final BuildContext context,
    required final String? stateName,
    required final FTextTypeInput valueToChangeWith,
    required final String? value,
    final int loop = 0,
  }) async {
    if (stateName == null) return;
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    final _value = value ??
        valueToChangeWith.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          loop,
          context,
        );
    updateStateValue(context, stateName, _value);
  }

  static String toCode({
    required final int pageId,
    required final BuildContext context,
    required final String? stateName,
    required final FTextTypeInput? valueToChangeWith,
    final bool isValueDefault = false,
    final int loop = 0,
  }) {
    if (valueToChangeWith != null && stateName != null) {
      final page = getPageOnToCode(pageId, context);
      final variable = takeStateFrom(page, stateName);
      if (variable == null) return '';

      final varName = ReCase(stateName).camelCase;

      final value = valueToChangeWith.toCode(
        loop,
        resultType: variable.type == VariableType.string
            ? ResultTypeEnum.string
            : variable.type == VariableType.int
                ? ResultTypeEnum.int
                : variable.type == VariableType.double
                    ? ResultTypeEnum.double
                    : ResultTypeEnum.bool,
        defaultValue: variable.type == VariableType.string
            ? ''
            : variable.type == VariableType.int
                ? '0'
                : variable.type == VariableType.double
                    ? '0.0'
                    : 'false',
      );

      if (isValueDefault) {
        return '''
          setState(() {
            $varName = value;
          });
        ''';
      }

      final buffer = StringBuffer()..write('');
      //this will be inserted in a onChange (string value) method so this should work like this
      if (variable.type == VariableType.string) {
        if (value.contains(r'${')) {
          buffer.write(
            '$varName = $value;',
          );
        } else {
          buffer.write(
            "$varName = ${value.isNotEmpty ? value : 'value'};",
          );
        }
      } else {
        if (variable.type == VariableType.int) {
          final v = value.replaceAll("'", '');
          Logger.printWarning(v);
          buffer.write(
            '$varName = ${int.tryParse(v) ?? v};',
          );
        } else if (variable.type == VariableType.double) {
          final v = value.replaceAll("'", '');
          buffer.write(
            '$varName = ${double.tryParse(v) ?? v};',
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
    return '';
  }
}
