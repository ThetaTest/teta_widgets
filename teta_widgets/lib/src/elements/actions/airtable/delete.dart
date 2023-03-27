import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/cubits/airtable.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_models/theta_models.dart';

class FAAirtableDelete {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? airtableRecordName,
    final List<MapElement> airtableData,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final airtableCubit = BlocProvider.of<AirtableCubit>(context);
    final recordName = airtableRecordName?.get(
          params,
          states,
          dataset,
          false,
          loop,
          context,
        ) ??
        '';

    final record = AirtableRecord(
      fields: airtableData
          .map(
            (final e) => AirtableRecordField(fieldName: e.key, value: e.value),
          )
          .toList(),
    );

    await airtableCubit.delete(recordName: recordName, record: record);
  }

  static String toCode(
    final BuildContext context,
    final FTextTypeInput? airtableRecordName,
    final List<MapElement> airtableData,
  ) {
    List<String> stringRecordField = [];

    for (var element in airtableData) {
      stringRecordField.add(
          'AirtableRecordField(fieldName: ${element.key}, value: ${element.value.toCode(0, resultType: ResultTypeEnum.string)})');
    }

    final stringRecord = '''
        AirtableRecord(
        fields: $stringRecordField)
    ''';

    return '''
    AirtableInstance.instance.delete(recordName: ${airtableRecordName?.toCode(
              0,
              resultType: ResultTypeEnum.string,
            ) ?? ''}, record: $stringRecord);
    ''';
  }
}
