import 'package:theta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsSetUserPropertyParams extends TetaActionParams {
  const TAFirebaseAnalyticsSetUserPropertyParams({
    this.propertyName,
    this.propertyValue,
  });

  const TAFirebaseAnalyticsSetUserPropertyParams.empty()
      : propertyName = null,
        propertyValue = null;

  TAFirebaseAnalyticsSetUserPropertyParams.fromJson(Map<String, dynamic> json)
      : propertyName = json['sFirebaseAnalyticsName'] != null
            ? FTextTypeInput.fromJson(
                json['sFirebaseAnalyticsName'] as Map<String, dynamic>,
              )
            : null,
        propertyValue = json['sFirebaseAnalyticsValue'] != null
            ? FTextTypeInput.fromJson(
                json['sFirebaseAnalyticsValue'] as Map<String, dynamic>,
              )
            : null;

  final FTextTypeInput? propertyName;
  final FTextTypeInput? propertyValue;

  @override
  Map<String, dynamic> toJson() => {
        'sFirebaseAnalyticsName': propertyName?.toJson(),
        'sFirebaseAnalyticsValue': propertyValue?.toJson(),
      };
}
