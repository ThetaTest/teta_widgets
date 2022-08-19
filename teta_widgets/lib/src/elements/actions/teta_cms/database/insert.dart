// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
// Package imports:
import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class FATetaCMSInsert {
  static Future action(
    final BuildContext context,
    final String? collectionId,
    final List<MapElement>? dbData,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final map = <String, dynamic>{};
    for (final e in dbData ?? <MapElement>[]) {
      map[e.key] = e.value.get(
        params,
        states,
        dataset,
        true,
        loop,
        context,
      );
    }
    await TetaCMS.instance.client.insertDocument(collectionId!, map);
  }

  static String toCode(
    final String? collectionId,
    final List<MapElement>? dbData,
  ) {
    final map = <String, dynamic>{};
    for (final e in dbData ?? <MapElement>[]) {
      if (e.key.toLowerCase() != 'id') {
        if (e.value.type == FTextTypeEnum.text) {
          map[e.key] = '"${e.value.toCode(0)}"';
        } else {
          map[e.key] = e.value.toCode(0);
        }
      } else {
        map[e.key] = int.tryParse(e.value.toCode(0));
      }
    }
    final mapString = StringBuffer()..write('{');
    for (final key in map.keys) {
      mapString.write("'$key': ${map[key]},");
    }
    mapString.write('}');
    return "await TetaCMS.instance.client.insertDocument('$collectionId', <String, dynamic>$mapString);";
  }
}
