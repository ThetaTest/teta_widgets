import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAGoogleMapsSetCameraPosition extends TetaAction {
  TAGoogleMapsSetCameraPosition({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAGoogleMapsSetCameraPosition.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAGoogleMapsSetCameraPositionParams.fromJson(
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
  TAGoogleMapsSetCameraPositionParams get params =>
      super.params as TAGoogleMapsSetCameraPositionParams;

  @override
  TetaActionType get type => TetaActionType.googleMapsSetCameraPosition;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) {
    //TODO(Andrei): Emit change position state
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
    final variable = takeStateFrom(page, '${params.stateName}');
    if (variable == null || params.stateName == null) return '';

    final cubitNameFinal = ReCase(params.stateName!).camelCase;

    return '''
       $cubitNameFinal?.onEmitNewCameraPosition(
        ${params.lat},
        ${params.lng},
        ${params.zoom},
      );
    ''';
  }
}
