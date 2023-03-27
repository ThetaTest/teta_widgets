import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAAudioPlayerReload extends TetaAction {
  TAAudioPlayerReload({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAAudioPlayerReload.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAAudioPlayerReloadParams.fromJson(
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
  TAAudioPlayerReloadParams get params =>
      super.params as TAAudioPlayerReloadParams;

  @override
  TetaActionType get type => TetaActionType.audioPlayerReload;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final variable = state.states
        .firstWhereOrNull((final element) => element.name == params.stateName);
    if (variable?.audioController != null) {
      await variable?.audioController?.load();
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
    if ($varName != null) { 
      await $varName.load();
    }''';
  }
}
