// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:

class FATetaCMSUpdate {
  static Future action(
    final BuildContext context,
    final String collectionId,
    final String documentId, {
    final List<MapElement> list = const <MapElement>[],
  }) async {
    final map = <String, dynamic>{};
    for (final e in list) {
      map[e.key] = e.value;
    }
    final resp = await TetaCMS.instance.client.updateDocument(
      collectionId,
      documentId,
      map,
    );
  }

  static String toCode(
    final BuildContext context,
    final String collectionId,
    final String documentId, {
    final List<MapElement> list = const <MapElement>[],
  }) {
    final map = <String, dynamic>{};
    for (final e in list) {
      map[e.key] = e.value;
    }
    return "final resp = await TetaCMS.instance.client.updateDocument('$collectionId', '$documentId', $map);";
  }
}
