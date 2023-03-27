import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/index.dart';
import '../../../../features/text_type_input.dart';
import 'params.dart';

class TATetaCMSUpdate extends TetaAction {
  TATetaCMSUpdate({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TATetaCMSUpdate.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TATetaCMSUpdateParams.fromJson(
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
  TATetaCMSUpdateParams get params => super.params as TATetaCMSUpdateParams;

  @override
  TetaActionType get type => TetaActionType.tetaCmsDbUpdate;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final map = <String, dynamic>{};
    for (final e in params.dbData ?? <MapElement>[]) {
      map[e.key] = e.value.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
    }
    String? docId;
    docId = params.documentId?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    if (params.collectionId != null && docId != null) {
      await TetaCMS.I.db.from(params.collectionId!).row(docId).update(map);
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final map = <String, dynamic>{};
    for (final e in params.dbData ?? <MapElement>[]) {
      map[e.key] = e.value.toCode(
        0,
        resultType: ResultTypeEnum.string,
      );
    }
    final eqValue = params.documentId?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final mapString = StringBuffer()..write('{');
    for (final key in map.keys) {
      mapString.write("'''$key''': '${map[key]}',");
    }
    mapString.write('}');
    return "await TetaCMS.I.db.from('${params.collectionId}').row($eqValue).update($map);";
  }
}
