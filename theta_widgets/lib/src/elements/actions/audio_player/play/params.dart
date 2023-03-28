import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAAudioPlayerPlayParams extends TetaActionParams {
  const TAAudioPlayerPlayParams({
    required this.stateName,
  });

  const TAAudioPlayerPlayParams.empty() : stateName = null;

  TAAudioPlayerPlayParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
