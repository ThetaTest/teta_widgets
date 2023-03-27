import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TAMixpanelSetUserIdParams extends TetaActionParams {
  const TAMixpanelSetUserIdParams({
    required this.userIdValue,
  });

  const TAMixpanelSetUserIdParams.empty() : userIdValue = null;

  TAMixpanelSetUserIdParams.fromJson(final Map<String, dynamic> json)
      : userIdValue = json['vTTI'] as FTextTypeInput?;

  final FTextTypeInput? userIdValue;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'vTTI': userIdValue,
      };

  TAMixpanelSetUserIdParams copyWith({
    final FTextTypeInput? userIdValue,
  }) =>
      TAMixpanelSetUserIdParams(
        userIdValue: userIdValue ?? this.userIdValue,
      );
}
