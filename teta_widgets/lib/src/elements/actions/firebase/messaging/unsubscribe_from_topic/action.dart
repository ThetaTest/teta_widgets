import 'package:flutter/material.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/teta_widget_state.dart';
import '../../../../features/text_type_input.dart';
import 'params.dart';

class TAFirebaseMessagingUnsubscribeTopic extends TetaAction {
  TAFirebaseMessagingUnsubscribeTopic({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAFirebaseMessagingUnsubscribeTopic.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAFirebaseMessagingUnsubscribeTopicParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TAFirebaseMessagingUnsubscribeTopicParams get params =>
      super.params as TAFirebaseMessagingUnsubscribeTopicParams;

  @override
  TetaActionType get type => TetaActionType.firebaseMessagingSubscribeToTopic;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final firebaseMessagesTopicNew = params.firebaseMessagesTopic?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const TAlertTitle('Firebase Messages'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          backgroundColor: const Color(0xFF333333),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 400,
            height: 400,
            child: Text(
              '(Firebase Messages- Subscribe To Topic- $firebaseMessagesTopicNew ) will be activated in your released app.',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final firebaseMessagesTopicNew = params.firebaseMessagesTopic
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll(' ', '');
    return '''
    await FirebaseMessaging.instance.unsubscribeFromTopic($firebaseMessagesTopicNew);
    ''';
  }
}
