import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAQonversionRestoreParams extends TetaActionParams {
  const TAQonversionRestoreParams({
    required this.stateName,
  });

  const TAQonversionRestoreParams.empty() : stateName = null;

  TAQonversionRestoreParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
