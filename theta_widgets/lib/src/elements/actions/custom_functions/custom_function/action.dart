import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';
import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TACustomFunction extends TetaAction {
  TACustomFunction({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TACustomFunction.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TACustomFunctionParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TACustomFunctionParams get params => super.params as TACustomFunctionParams;

  @override
  TetaActionType get type => TetaActionType.customFunction;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) {
    return showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: Text('Custom Function ${params.customFunctionId}'),
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

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    try {
      final functions = BlocProvider.of<CustomFunctionsCubit>(context).state;
      String code;
      if (functions.isNotEmpty) {
        final func = functions.firstWhere(
          (final element) => element.id == params.customFunctionId,
        );
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
