import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerLoopOffParams extends TetaActionParams {
  const TAAudioPlayerLoopOffParams({
    required this.stateName,
  });

  const TAAudioPlayerLoopOffParams.empty() : stateName = null;

  TAAudioPlayerLoopOffParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
