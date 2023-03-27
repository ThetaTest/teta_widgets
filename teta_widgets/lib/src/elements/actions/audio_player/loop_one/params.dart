import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerLoopOneParams extends TetaActionParams {
  const TAAudioPlayerLoopOneParams({
    required this.stateName,
  });

  const TAAudioPlayerLoopOneParams.empty() : stateName = null;

  TAAudioPlayerLoopOneParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
