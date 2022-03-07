// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_page/index.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

class FAudioPlayerLoopOff {
  static Future action(
    BuildContext context,
    List<VariableObject> states,
    String? stateName,
  ) async {
    final variable =
        states.firstWhereOrNull((element) => element.name == stateName);
    if (variable?.audioController != null) {
      await variable?.audioController?.setLoopMode(LoopMode.off);
    }
  }

  static String toCode(BuildContext context, String? stateName) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    if ($varName != null) { 
      await $varName.setLoopMode(LoopMode.off);
    }''';
  }
}
