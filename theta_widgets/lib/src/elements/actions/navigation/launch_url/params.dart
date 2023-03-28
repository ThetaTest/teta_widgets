import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TANavigationLaunchUrlParams extends TetaActionParams {
  const TANavigationLaunchUrlParams({
    required this.value,
  });

  const TANavigationLaunchUrlParams.empty() : value = null;

  TANavigationLaunchUrlParams.fromJson(
    final Map<String, dynamic> json,
  ) : value = FTextTypeInput.fromJson(
          json['vTTI'] as Map<String, dynamic>?,
        );

  final FTextTypeInput? value;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'vTTI': value?.toJson(),
      };

  TANavigationLaunchUrlParams copyWith({
    final FTextTypeInput? value,
  }) {
    return TANavigationLaunchUrlParams(
      value: value ?? this.value,
    );
  }
}
