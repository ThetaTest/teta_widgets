import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerReloadParams extends TetaActionParams {
  const TAAudioPlayerReloadParams({
    required this.stateName,
  });

  const TAAudioPlayerReloadParams.empty() : stateName = null;

  TAAudioPlayerReloadParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
