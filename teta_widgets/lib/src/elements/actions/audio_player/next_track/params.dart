import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerNextTrackParams extends TetaActionParams {
  const TAAudioPlayerNextTrackParams({
    required this.stateName,
  });

  const TAAudioPlayerNextTrackParams.empty() : stateName = null;

  TAAudioPlayerNextTrackParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
