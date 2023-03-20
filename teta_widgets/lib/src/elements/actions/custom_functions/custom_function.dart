// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_front_end/teta_front_end.dart';

class FActionCustomFunction {
  static Future action(
    final BuildContext context,
    final int? customFunctionId,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: Text('Custom Function $customFunctionId'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          backgroundColor: const Color(0xFF333333),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        );
      },
    );
  }

  static String toCode(
    final BuildContext context,
    final int? customFunctionId,
  ) {
    try {
      final functions = BlocProvider.of<CustomFunctionsCubit>(context).state;
      String code;
      if (functions.isNotEmpty) {
        final func = functions.firstWhere((final element) => element.id == customFunctionId);
        code = func.code!;
      } else {
        code = '''print('default custom function');''';
      }
      return '''
      $code
      ''';
    } catch (e) {
      return '';
    }
  }
}
