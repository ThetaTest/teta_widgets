import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerLoopAllParams implements TetaActionParams {
  const TAAudioPlayerLoopAllParams({
    required this.stateName,
  });

  const TAAudioPlayerLoopAllParams.empty() : stateName = null;

  TAAudioPlayerLoopAllParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
