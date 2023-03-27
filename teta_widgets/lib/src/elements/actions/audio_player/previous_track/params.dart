import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerPreviousTrackParams extends TetaActionParams {
  const TAAudioPlayerPreviousTrackParams({
    required this.stateName,
  });

  const TAAudioPlayerPreviousTrackParams.empty() : stateName = null;

  TAAudioPlayerPreviousTrackParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
