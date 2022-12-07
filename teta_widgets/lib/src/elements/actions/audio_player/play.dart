// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';

class FAudioPlayerPlay {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String? stateName,
  ) async {
    final variable = state.states.firstWhereOrNull((final element) => element.name == stateName);
    final audioPlayer = variable?.audioController;
    try {
      if (audioPlayer != null) {
        if (state.loop != null) {
          if (audioPlayer.currentIndex != state.loop) {
            await audioPlayer.seek(Duration.zero, index: state.loop);
          }
        }
        await audioPlayer.play();
      }
    } catch (e) {
      print('Play exception->: $e');
    }
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? stateName,
  ) {
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
