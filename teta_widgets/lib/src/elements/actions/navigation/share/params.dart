import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TANavigationShareParams extends TetaActionParams {
  const TANavigationShareParams({
    required this.value,
  });

  const TANavigationShareParams.empty() : value = null;

  TANavigationShareParams.fromJson(final Map<String, dynamic> json)
      : value = FTextTypeInput.fromJson(
          json['vTTI'] as Map<String, dynamic>?,
        );

  final FTextTypeInput? value;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'vTTI': value?.toJson(),
      };

  TANavigationShareParams copyWith({
    final FTextTypeInput? value,
  }) {
    return TANavigationShareParams(
      value: value ?? this.value,
    );
  }
}
