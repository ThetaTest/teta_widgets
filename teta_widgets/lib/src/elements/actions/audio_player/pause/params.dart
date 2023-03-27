import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerPauseParams extends TetaActionParams {
  const TAAudioPlayerPauseParams({
    required this.stateName,
  });

  const TAAudioPlayerPauseParams.empty() : stateName = null;

  TAAudioPlayerPauseParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
