import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAGoogleMapsUpdateLivePosition extends TetaAction {
  TAGoogleMapsUpdateLivePosition({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAGoogleMapsUpdateLivePosition.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAGoogleMapsUpdateLivePositionParams.fromJson(
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
  TAGoogleMapsUpdateLivePositionParams get params =>
      super.params as TAGoogleMapsUpdateLivePositionParams;

  @override
  TetaActionType get type => TetaActionType.googleMapsUpdateDeviceLiveLocation;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) {
    //TODO(Andrei): Do same as below
    return Future<void>.value();
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final latVariable = takeStateFrom(page, '${params.latName}');
    if (latVariable == null || params.latName == null) return '';

    final lngVariable = takeStateFrom(page, '${params.lngName}');
    if (lngVariable == null || params.lngName == null) return '';

    final latVarFinalName = ReCase(params.latName!).camelCase;
    final lngVarFinalName = ReCase(params.lngName!).camelCase;

    return '''
    final location = Location();
    await location.changeSettings(distanceFilter: 30);
    location.onLocationChanged.listen((final event) { 
      $latVarFinalName = event.latitude!;
      $lngVarFinalName = event.longitude!;
    });
    ''';
  }
}
