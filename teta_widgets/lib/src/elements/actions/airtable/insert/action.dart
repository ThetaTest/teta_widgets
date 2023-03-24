import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import 'params.dart';

class TAAirtableInsert extends TetaAction {
  TAAirtableInsert({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAAirtableInsert.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAAirtableInsertParams.fromJson(
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
  TAAirtableInsertParams get params => super.params as TAAirtableInsertParams;

  @override
  TetaActionType get type => TetaActionType.airtableInsert;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final airtableCubit = BlocProvider.of<AirtableCubit>(context);
    final recordName = params.airtableRecordName?.get(
          state.params,
          state.states,
          state.dataset,
          false,
          state.loop,
          context,
        ) ??
        '';

    final record = AirtableRecord(
      fields: params.airtableData
          .map(
            (final e) => AirtableRecordField(fieldName: e.key, value: e.value),
          )
          .toList(),
    );

    await airtableCubit.insert(recordName: recordName, record: record);
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final stringRecordField = <String>[];

    for (final element in params.airtableData) {
      stringRecordField.add(
        'AirtableRecordField(fieldName: ${element.key}, value: ${element.value.toCode(0, resultType: ResultTypeEnum.string)})',
      );
    }

    final stringRecord = '''
        AirtableRecord(
        fields: $stringRecordField)
    ''';

    return '''
    AirtableInstance.instance.insert(recordName: ${params.airtableRecordName?.toCode(
              0,
              resultType: ResultTypeEnum.string,
            ) ?? ''}, record: $stringRecord);
    ''';
  }
}
