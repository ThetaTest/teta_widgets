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

class FATetaCMSUpdate {
  static Future action(
    final BuildContext context,
    final String? collectionId,
    final List<MapElement>? list,
    final FTextTypeInput? documentId,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final map = <String, dynamic>{};
    for (final e in list ?? <MapElement>[]) {
      map[e.key] = e.value.get(params, states, dataset, true, loop, context);
    }
    String? docId;
    docId = documentId?.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    if (collectionId != null && docId != null) {
      await TetaCMS.I.db.from(name: collectionId).doc(docId).update(
            map,
          );
    }
  }

  static String toCode(
    final String? collectionId,
    final List<MapElement>? list,
    final FTextTypeInput? documentId,
    final int? loop,
  ) {
    final map = <String, dynamic>{};
    for (final e in list ?? <MapElement>[]) {
      map[e.key] = e.value.toCode(
        0,
        resultType: ResultTypeEnum.string,
      );
    }
    final eqValue = documentId?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final mapString = StringBuffer()..write('{');
    for (final key in map.keys) {
      mapString.write("'''$key''': '${map[key]}',");
    }
    mapString.write('}');
    return "await TetaCMS.instance.client.updateDocument('$collectionId', $eqValue, $map);";
  }
}
