import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_cms/teta_cms.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/index.dart';
import '../../../../features/text_type_input.dart';
import 'params.dart';

class TATetaCMSDelete extends TetaAction {
  TATetaCMSDelete({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TATetaCMSDelete.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TATetaCMSDeleteParams.fromJson(
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
  TATetaCMSDeleteParams get params => super.params as TATetaCMSDeleteParams;

  @override
  TetaActionType get type => TetaActionType.tetaCmsDbDelete;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (params.collectionId == null) return;

    final docId = params.documentId?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    if (params.collectionId != null && docId != null) {
      await TetaCMS.I.db.from(params.collectionId!).row(docId).delete();
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final eqValue = params.documentId?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    return "await TetaCMS.I.db.from('${params.collectionId}').row($eqValue).delete();";
  }
}
