import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsLogScreenViewParams extends TetaActionParams {
  const TAFirebaseAnalyticsLogScreenViewParams({
    required this.firebaseAnalyticsScreenName,
  });

  const TAFirebaseAnalyticsLogScreenViewParams.empty()
      : firebaseAnalyticsScreenName = null;

  TAFirebaseAnalyticsLogScreenViewParams.fromJson(Map<String, dynamic> json)
      : firebaseAnalyticsScreenName = FTextTypeInput.fromJson(
            json['sFirebaseAnalyticsScreenName'] as Map<String, dynamic>?);

  final FTextTypeInput? firebaseAnalyticsScreenName;

  @override
  Map<String, dynamic> toJson() => {
        'sFirebaseAnalyticsScreenName': firebaseAnalyticsScreenName?.toJson(),
      };
}
