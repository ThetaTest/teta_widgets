import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TARevenueCatRestoreParams extends TetaActionParams {
  const TARevenueCatRestoreParams({
    required this.stateName,
  });

  const TARevenueCatRestoreParams.empty() : stateName = null;

  TARevenueCatRestoreParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
