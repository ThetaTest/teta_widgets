import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsSetUserIdParams extends TetaActionParams {
  const TAFirebaseAnalyticsSetUserIdParams({
    this.stateName,
    this.firebaseAnalyticsUserId,
  });

  const TAFirebaseAnalyticsSetUserIdParams.empty()
      : stateName = null,
        firebaseAnalyticsUserId = null;

  TAFirebaseAnalyticsSetUserIdParams.fromJson(Map<String, dynamic> json)
      : stateName = json['sN'] as String?,
        firebaseAnalyticsUserId = FTextTypeInput.fromJson(
            json['sFirebaseAnalyticsUserId'] as Map<String, dynamic>?);

  final String? stateName;
  final FTextTypeInput? firebaseAnalyticsUserId;

  @override
  Map<String, dynamic> toJson() => {
        'sN': stateName,
        'sFirebaseAnalyticsUserId': firebaseAnalyticsUserId?.toJson(),
      };
}
