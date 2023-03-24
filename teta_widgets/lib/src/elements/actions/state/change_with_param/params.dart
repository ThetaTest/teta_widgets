import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAStateChangeWithParamParams extends TetaActionParams {
  const TAStateChangeWithParamParams({
    required this.stateName,
    required this.paramName,
  });

  const TAStateChangeWithParamParams.empty()
      : stateName = null,
        paramName = null;

  TAStateChangeWithParamParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?,
        paramName = json['v'] as String?;

  final String? stateName;
  final String? paramName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
        'v': paramName,
      };
}
