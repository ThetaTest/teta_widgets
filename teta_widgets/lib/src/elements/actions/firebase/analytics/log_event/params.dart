import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseAnalyticsLogEventParams extends TetaActionParams {
  const TAFirebaseAnalyticsLogEventParams({
    required this.parameters,
    required this.eventName,
  });

  const TAFirebaseAnalyticsLogEventParams.empty()
      : parameters = null,
        eventName = null;

  TAFirebaseAnalyticsLogEventParams.fromJson(Map<String, dynamic> json)
      : parameters = json['sFirebaseAnalyticsParameters'] != null
            ? (json['sFirebaseAnalyticsParameters'] as List)
                .map((e) => MapElement.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
        eventName = FTextTypeInput.fromJson(
            json['seventName'] as Map<String, dynamic>?);

  final List<MapElement>? parameters;
  final FTextTypeInput? eventName;

  @override
  Map<String, dynamic> toJson() => {
        'seventName': eventName?.toJson(),
        'sFirebaseAnalyticsParameters':
            parameters?.map((e) => e.toJson()).toList(),
      };
}
