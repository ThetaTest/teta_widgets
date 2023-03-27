import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAStateDecrementParams extends TetaActionParams {
  const TAStateDecrementParams({
    required this.stateName,
  });

  const TAStateDecrementParams.empty() : stateName = null;

  TAStateDecrementParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
