// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
// Package imports:
import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:
import 'package:teta_models/teta_models.dart';

class FATetaCMSInsert {
  static Future action(
    final BuildContext context,
    final String? collectionName,
    final List<MapElement>? dbData,
    final TetaWidgetState state,
  ) async {
    final map = <String, dynamic>{};
    for (final e in dbData ?? <MapElement>[]) {
      map[e.key] = e.value.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
    }
    await TetaCMS.I.db.from(collectionName!).insert(map);
  }

  static String toCode(
    final String? collectionName,
    final List<MapElement>? dbData,
  ) {
    final map = <String, dynamic>{};
    for (final e in dbData ?? <MapElement>[]) {
      if (e.key.toLowerCase() != 'id') {
        if (e.value.type == FTextTypeEnum.text) {
          map[e.key] = e.value.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
        } else {
          map[e.key] = e.value.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
        }
      } else {
        map[e.key] = int.tryParse(
          e.value.toCode(
            0,
            resultType: ResultTypeEnum.int,
          ),
        );
      }
    }
    final mapString = StringBuffer()..write('{');
    for (final key in map.keys) {
      mapString.write("'$key': ${map[key]},");
    }
    mapString.write('}');
    return "await TetaCMS.I.db.from('$collectionName').insert(<String, dynamic>$mapString);";
  }
}
