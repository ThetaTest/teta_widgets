// Flutter imports:
// ignore_for_file: public_member_api_docs

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/cubits/active_actions_timers/cubit.dart';
// Project imports:
import '../features/text_type_input.dart';

class FLoop {
  static void action(
    final Function() function,
    final FTextTypeInput? ms,
    final BuildContext context, {
    required final bool withLoop,
  }) {
    if (withLoop == true) {
      BlocProvider.of<ActiveActionsTimers>(context).add(
        Timer.periodic(
          Duration(milliseconds: int.tryParse('${ms?.value}') ?? 0),
          (final Timer t) {
            function();
          },
        ),
      );
    } else {
      function();
    }
  }

  static String toCode(
    final int delay,
    final String content, {
    required final bool withLoop,
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
