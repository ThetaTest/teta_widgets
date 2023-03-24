import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TACameraStartRecordingParams extends TetaActionParams {
  const TACameraStartRecordingParams({
    required this.stateName,
  });

  const TACameraStartRecordingParams.empty() : stateName = null;

  TACameraStartRecordingParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'sN': stateName};

  TACameraStartRecordingParams copyWith({
    final String? stateName,
  }) {
    return TACameraStartRecordingParams(
      stateName: stateName ?? this.stateName,
    );
  }
}
