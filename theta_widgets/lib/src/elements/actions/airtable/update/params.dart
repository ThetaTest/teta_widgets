import 'package:theta_models/theta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../features/text_type_input.dart';

class TAAirtableUpdateParams implements TetaActionParams {
  const TAAirtableUpdateParams({
    required this.airtableRecordName,
    required this.airtableData,
  });

  const TAAirtableUpdateParams.empty()
      : airtableRecordName = null,
        airtableData = const [];

  TAAirtableUpdateParams.fromJson(final Map<String, dynamic> json)
      : airtableData = (json['sData'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
        airtableRecordName = FTextTypeInput.fromJson(
          json['recordName'] as Map<String, dynamic>?,
        );

  final FTextTypeInput? airtableRecordName;
  final List<MapElement> airtableData;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sData': airtableData.map((final e) => e.toJson()).toList(),
        'recordName': airtableRecordName?.toJson(),
      };
}
