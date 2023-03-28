import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsLogLoginParams extends TetaActionParams {
  const TAFirebaseAnalyticsLogLoginParams({
    required this.firebaseAnalyticsLoginMethod,
  });

  const TAFirebaseAnalyticsLogLoginParams.empty()
      : firebaseAnalyticsLoginMethod = null;

  TAFirebaseAnalyticsLogLoginParams.fromJson(Map<String, dynamic> json)
      : firebaseAnalyticsLoginMethod = FTextTypeInput.fromJson(
            json['sFirebaseAnalyticsLoginMethod'] as Map<String, dynamic>?);

  final FTextTypeInput? firebaseAnalyticsLoginMethod;

  @override
  Map<String, dynamic> toJson() => {
        'sFirebaseAnalyticsLoginMethod': firebaseAnalyticsLoginMethod?.toJson(),
      };
}
