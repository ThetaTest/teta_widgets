import '../../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../features/text_type_input.dart';

class TATetaCMSOnAllParams implements TetaActionParams {
  const TATetaCMSOnAllParams({
    required this.collection,
    required this.stateName,
  });

  const TATetaCMSOnAllParams.empty()
      : collection = null,
        stateName = null;

  TATetaCMSOnAllParams.fromJson(final Map<String, dynamic> json)
      : collection = json['cmsCId'] != null
            ? FTextTypeInput.fromJson(json['cmsCId'] as Map<String, dynamic>)
            : FTextTypeInput(),
        stateName = json['sN'] as String?;

  final FTextTypeInput? collection;
  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'cmsCId': collection?.toJson(),
        'sN': stateName,
      };

  TATetaCMSOnAllParams copyWith({
    final FTextTypeInput? collection,
    final String? stateName,
  }) {
    return TATetaCMSOnAllParams(
      collection: collection ?? this.collection,
      stateName: stateName ?? this.stateName,
    );
  }
}
