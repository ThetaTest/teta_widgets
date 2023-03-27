import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TACameraStopRecordingParams extends TetaActionParams {
  const TACameraStopRecordingParams({
    required this.stateName,
  });

  const TACameraStopRecordingParams.empty() : stateName = null;

  TACameraStopRecordingParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'sN': stateName};

  TACameraStopRecordingParams copyWith({
    final String? stateName,
  }) {
    return TACameraStopRecordingParams(
      stateName: stateName ?? this.stateName,
    );
  }
}
