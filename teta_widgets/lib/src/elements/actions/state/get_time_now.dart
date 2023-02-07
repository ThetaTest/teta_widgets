// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_widgets/src/elements/index.dart';

class FActionStateGetTimeHour {
  static Future action({
    required final BuildContext context,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> datasets,
    required final String? stateName,
    final int loop = 0,
  }) async {
    updateStateValue(
      context,
      stateName!,
      DateTime.now().hour.toString(),
    );
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
        resultType: ResultTypeEnum.string,
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
        buffer.write(
          '$varName = DateTime.now().hour.toString();',
        );
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
