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

class FActionGoogleMapsUpdateDeviceLiveLocation {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? latName,
    final String? lngName,
    final int? loop,
  ) async {
    //TODO(Andrei): Do same as below
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? latName,
    final String? lngName,
    final int? loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final latVariable = takeStateFrom(page, '$latName');
    if (latVariable == null || latName == null) return '';

    final lngVariable = takeStateFrom(page, '$lngName');
    if (lngVariable == null || lngName == null) return '';

    final latVarFinalName = ReCase(latName).camelCase;
    final lngVarFinalName = ReCase(lngName).camelCase;

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
