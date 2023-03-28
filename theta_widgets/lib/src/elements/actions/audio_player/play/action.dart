import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAAudioPlayerPlay extends TetaAction {
  TAAudioPlayerPlay({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAAudioPlayerPlay.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAAudioPlayerPlayParams.fromJson(
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
  TAAudioPlayerPlayParams get params => super.params as TAAudioPlayerPlayParams;

  @override
  TetaActionType get type => TetaActionType.audioPlayerPlay;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final variable = state.states.firstWhereOrNull(
      (final element) => element.name == params.stateName,
    );
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
      log('Play exception->: $e', name: runtimeType.toString());
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (params.stateName == null) return '';
    final variable = takeStateFrom(page, params.stateName!);
    if (variable == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    return '''
      if($varName?.currentIndex! != index) {
        await $varName?.seek(Duration.zero, index: index);
      }
      $varName?.play();
    ''';
  }
}
