import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/index.dart';

class LocationTemplate {
  static String toCode(
      final int pageId,
      final BuildContext context,
      final String? latName,
      final String? lngName,
      final int? loop,
      final CNode node,
      ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final latVariable = takeStateFrom(page, '$latName');
    if (latVariable == null || latName == null) return '';

    final lngVariable = takeStateFrom(page, '$lngName');
    if (lngVariable == null || lngName == null) return '';

    final latVarFinalName = ReCase(latName).camelCase;
    final lngVarFinalName = ReCase(lngName).camelCase;

    final onEmitNewValue = CS.getActionsInFormOfFutureDelayed(
      pageId,
      context,
      node,
      ActionGesture.onStreamNewValue,
      '',
      loop: loop,
    );
    return '''
          unawaited(
        Future.delayed(
          Duration.zero,
          () async {
      await Geolocator.requestPermission();
      final location = await Geolocator.getCurrentPosition();
      Geolocator.getPositionStream(locationSettings: const LocationSettings(distanceFilter: 20)).listen((final event) { 
      $latVarFinalName = event.latitude!;
      $lngVarFinalName = event.longitude!;
      
      $onEmitNewValue
    });
              },
        ),
      );
    ''';
  }
}