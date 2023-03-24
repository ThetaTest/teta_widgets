import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAGoogleMapsReloadData extends TetaAction {
  TAGoogleMapsReloadData({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAGoogleMapsReloadData.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAGoogleMapsReloadDataParams.fromJson(
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
  TAGoogleMapsReloadDataParams get params =>
      super.params as TAGoogleMapsReloadDataParams;

  @override
  TetaActionType get type => TetaActionType.googleMapsReloadData;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) {
    //TODO(Andrei): Set new state with initialState boolean to true
    return Future<void>.value();
    // final variable =
    //     states.firstWhereOrNull((final element) => element.name == stateName);
    // final audioPlayer = variable?.audioController;
    // try {
    //   if (audioPlayer != null) {
    //     if (loop != null) {
    //       if (audioPlayer.currentIndex != loop) {
    //         await audioPlayer.seek(Duration.zero, index: loop);
    //       }
    //     }
    //     await audioPlayer.play();
    //   }
    // } catch (e) {
    //   print('Play exception->: $e');
    // }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, '${params.mapsControllerName}');
    if (variable == null || params.mapsControllerName == null) return '';

    final controllerNameFinal = ReCase(params.mapsControllerName!).camelCase;

    return '$controllerNameFinal?.onResetToInitialState();';
  }
}
