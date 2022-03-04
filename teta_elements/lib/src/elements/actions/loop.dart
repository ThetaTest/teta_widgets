// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/cubits/active_actions_timers/cubit.dart';
import 'package:teta_elements/src/elements/features/text_type_input.dart';

class FLoop {
  static void action(
    Function() function,
    FTextTypeInput? ms,
    BuildContext context, {
    required bool withLoop,
  }) {
    if (withLoop == true) {
      BlocProvider.of<ActiveActionsTimers>(context).add(
        Timer.periodic(
          Duration(milliseconds: int.tryParse('${ms?.value}') ?? 0),
          (Timer t) {
            function();
          },
        ),
      );
    } else {
      function();
    }
  }

  static String toCode(
    int delay,
    String content, {
    required bool withLoop,
  }) {
    if (withLoop != true) return content;
    if (delay == 0) return content;
    return '''
      Timer.periodic(Duration(milliseconds: $delay),
          (Timer t) {
        $content
      });
    ''';
  }
}
