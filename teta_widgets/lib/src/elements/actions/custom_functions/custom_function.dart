// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:

class FActionCustomFunction {
  static Future action(
    final BuildContext context,
    final int? loop,
    final int? customFunctionId,
  ) async {
    const _style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20,
    );
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: Text('Custom Functions: $customFunctionId'),
          titleTextStyle: _style,
          backgroundColor: const Color(0xFF333333),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 400,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  Text(
                    'Runned',
                    style: _style,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static String toCode(
    final BuildContext context,
    final int? customFunctionId,
  ) {
    
    final functions = BlocProvider.of<CustomFunctionsCubit>(context).state;
    String code;
    if (functions.isNotEmpty) {
      final func = functions
          .firstWhere((final element) => element.id == customFunctionId);
      code = func.code!;
    } else {
      code = '''print('default value')''';
    }
    return '''
      $code
    ''';
  }
}
