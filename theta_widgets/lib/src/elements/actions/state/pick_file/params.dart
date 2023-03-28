import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAStatePickFileParams extends TetaActionParams {
  const TAStatePickFileParams({
    required this.stateName,
  });

  const TAStatePickFileParams.empty() : stateName = null;

  TAStatePickFileParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
