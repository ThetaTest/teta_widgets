import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAStateIncrementParams extends TetaActionParams {
  const TAStateIncrementParams({
    required this.stateName,
  });

  const TAStateIncrementParams.empty() : stateName = null;

  TAStateIncrementParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
