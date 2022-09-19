// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';
import 'package:teta_widgets/src/elements/index.dart';

class FActionStateChangeWith {
  static Future action({
    required final BuildContext context,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> datasets,
    required final String? stateName,
    required final FTextTypeInput valueToChangeWith,
    required final String? value,
    final int loop = 0,
  }) async {
    try {
      final index =
          states.indexWhere((final element) => element.name == stateName);
      if (index >= 0) {
        states[index].value = value ??
            valueToChangeWith.get(
              params,
              states,
              datasets,
              true,
              loop,
              context,
            );
        update(context);
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
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
      if (page == null) return '';
      final variable = takeStateFrom(page, stateName);
      if (variable == null) return '';

      final varName = ReCase(stateName).camelCase;

      final value = valueToChangeWith.toCode(loop);

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
