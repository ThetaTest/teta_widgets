import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsSetCurrentScreenParams extends TetaActionParams {
  const TAFirebaseAnalyticsSetCurrentScreenParams({required this.screenName});

  const TAFirebaseAnalyticsSetCurrentScreenParams.empty() : screenName = null;

  TAFirebaseAnalyticsSetCurrentScreenParams.fromJson(
    final Map<String, dynamic> json,
  ) : screenName = json['sFirebaseAnalyticsScreenName'] != null
            ? FTextTypeInput.fromJson(
                json['sFirebaseAnalyticsScreenName'] as Map<String, dynamic>,
              )
            : null;

  final FTextTypeInput? screenName;

  @override
  Map<String, dynamic> toJson() => {
        'sFirebaseAnalyticsScreenName': screenName?.toJson(),
      };
}
