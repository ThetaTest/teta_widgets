import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseMessagingSubscribeTopicParams extends TetaActionParams {
  const TAFirebaseMessagingSubscribeTopicParams({
    required this.firebaseMessagesTopic,
  });

  const TAFirebaseMessagingSubscribeTopicParams.empty()
      : firebaseMessagesTopic = null;

  TAFirebaseMessagingSubscribeTopicParams.fromJson(Map<String, dynamic> json)
      : firebaseMessagesTopic = json['sFirebaseMessagesTopic'] != null
            ? FTextTypeInput.fromJson(
                json['sFirebaseMessagesTopic'] as Map<String, dynamic>)
            : null;

  final FTextTypeInput? firebaseMessagesTopic;

  @override
  Map<String, dynamic> toJson() => {
        'sFirebaseMessagesTopic': firebaseMessagesTopic?.toJson(),
      };
}
