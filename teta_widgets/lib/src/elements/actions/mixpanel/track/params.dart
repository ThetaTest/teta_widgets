import 'package:teta_models/teta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TAMixpanelTrackParams extends TetaActionParams {
  const TAMixpanelTrackParams({
    required this.eventName,
    required this.props,
  });

  const TAMixpanelTrackParams.empty()
      : eventName = null,
        props = null;

  TAMixpanelTrackParams.fromJson(final Map<String, dynamic> json)
      : eventName = json['vTTI'] as FTextTypeInput?,
        props = json['sCustomHttpRequestBody'] as List<MapElement>?;

  final FTextTypeInput? eventName;
  final List<MapElement>? props;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'vTTI': eventName,
        'sCustomHttpRequestBody': props,
      };

  TAMixpanelTrackParams copyWith({
    final FTextTypeInput? eventName,
    final List<MapElement>? props,
  }) =>
      TAMixpanelTrackParams(
        eventName: eventName ?? this.eventName,
        props: props ?? this.props,
      );
}
