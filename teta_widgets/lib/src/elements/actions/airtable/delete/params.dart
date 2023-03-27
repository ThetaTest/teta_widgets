import 'package:teta_models/teta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../index.dart';

class TAAirtableDeleteParams extends TetaActionParams {
  const TAAirtableDeleteParams({
    required this.airtableData,
    required this.airtableRecordName,
  });

  const TAAirtableDeleteParams.empty()
      : airtableData = const [],
        airtableRecordName = null;

  TAAirtableDeleteParams.fromJson(final Map<String, dynamic> json)
      : airtableData = (json['sData'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
        airtableRecordName = FTextTypeInput.fromJson(
          json['recordName'] as Map<String, dynamic>,
        );

  final FTextTypeInput? airtableRecordName;
  final List<MapElement> airtableData;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sData': airtableData.map((final e) => e.toJson()).toList(),
        'recordName': airtableRecordName?.toJson(),
      };
}
