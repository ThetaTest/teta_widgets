import 'package:theta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../../features/text_type_input.dart';

class TAFirebaseMessagingUnsubscribeTopicParams extends TetaActionParams {
  const TAFirebaseMessagingUnsubscribeTopicParams({
    required this.firebaseMessagesTopic,
  });

  const TAFirebaseMessagingUnsubscribeTopicParams.empty()
      : firebaseMessagesTopic = null;

  TAFirebaseMessagingUnsubscribeTopicParams.fromJson(Map<String, dynamic> json)
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
