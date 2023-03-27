import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TANavigationOpenDatePickerParams extends TetaActionParams {
  const TANavigationOpenDatePickerParams({
    required this.stateName,
  });

  const TANavigationOpenDatePickerParams.empty() : stateName = null;

  TANavigationOpenDatePickerParams.fromJson(
    final Map<String, dynamic> json,
  ) : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };

  TANavigationOpenDatePickerParams copyWith({
    final String? stateName,
  }) =>
      TANavigationOpenDatePickerParams(
        stateName: stateName ?? this.stateName,
      );
}
