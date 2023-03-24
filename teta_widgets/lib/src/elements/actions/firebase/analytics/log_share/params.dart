import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsLogShareParams extends TetaActionParams {
  const TAFirebaseAnalyticsLogShareParams({
    required this.firebaseAnalyticsContentType,
    required this.firebaseAnalyticsItemId,
    required this.firebaseAnalyticsMethod,
  });

  const TAFirebaseAnalyticsLogShareParams.empty()
      : firebaseAnalyticsContentType = null,
        firebaseAnalyticsItemId = null,
        firebaseAnalyticsMethod = null;

  TAFirebaseAnalyticsLogShareParams.fromJson(Map<String, dynamic> json)
      : firebaseAnalyticsContentType = FTextTypeInput.fromJson(
            json['sFirebaseAnalyticsContentType'] as Map<String, dynamic>?),
        firebaseAnalyticsItemId = FTextTypeInput.fromJson(
            json['sFirebaseAnalyticsItemId'] as Map<String, dynamic>?),
        firebaseAnalyticsMethod = FTextTypeInput.fromJson(
            json['sFirebaseAnalyticsMethod'] as Map<String, dynamic>?);

  final FTextTypeInput? firebaseAnalyticsContentType;
  final FTextTypeInput? firebaseAnalyticsItemId;
  final FTextTypeInput? firebaseAnalyticsMethod;

  @override
  Map<String, dynamic> toJson() => {
        'sFirebaseAnalyticsContentType': firebaseAnalyticsContentType?.toJson(),
        'sFirebaseAnalyticsItemId': firebaseAnalyticsItemId?.toJson(),
        'sFirebaseAnalyticsMethod': firebaseAnalyticsMethod?.toJson(),
      };
}
