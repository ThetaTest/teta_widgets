// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

class FAudioPlayerPlay {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
      final int loop,
  ) async {
    final variable =
        states.firstWhereOrNull((final element) => element.name == stateName);
    final audioPlayer = variable?.audioController;
    try {
      if (audioPlayer != null) {
        if (audioPlayer.currentIndex != loop) {
          await audioPlayer.seek(Duration.zero, index: loop);
        }
        await audioPlayer.play();
      }
    } catch(e){
      print("Play exception->: ${e}");
    }
  }

  static String toCode(
      final int pageId, final BuildContext context, final String? stateName, final String url, final int? loop,) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
         if($varName?.currentIndex! != index) {
            await $varName?.seek(Duration.zero, index: index);
          }
          $varName?.play();
    ''';
  }
}
