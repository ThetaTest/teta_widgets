import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsLogJoinGroupParams extends TetaActionParams {
  const TAFirebaseAnalyticsLogJoinGroupParams({
    required this.firebaseAnalyticsGroupId,
  });

  const TAFirebaseAnalyticsLogJoinGroupParams.empty()
      : firebaseAnalyticsGroupId = null;

  TAFirebaseAnalyticsLogJoinGroupParams.fromJson(Map<String, dynamic> json)
      : firebaseAnalyticsGroupId = FTextTypeInput.fromJson(
            json['sFirebaseAnalyticsGroupId'] as Map<String, dynamic>?);

  final FTextTypeInput? firebaseAnalyticsGroupId;

  @override
  Map<String, dynamic> toJson() => {
        'sFirebaseAnalyticsGroupId': firebaseAnalyticsGroupId?.toJson(),
      };
}
