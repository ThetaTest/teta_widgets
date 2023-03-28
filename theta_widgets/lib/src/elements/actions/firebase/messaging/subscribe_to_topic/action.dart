import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
import 'package:theta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/teta_widget_state.dart';
import '../../../../features/text_type_input.dart';
import 'params.dart';

class TAFirebaseMessagingSubscribeTopic extends TetaAction {
  TAFirebaseMessagingSubscribeTopic({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAFirebaseMessagingSubscribeTopic.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAFirebaseMessagingSubscribeTopicParams.fromJson(
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
  TAFirebaseMessagingSubscribeTopicParams get params =>
      super.params as TAFirebaseMessagingSubscribeTopicParams;

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
    await FirebaseMessaging.instance.subscribeToTopic($firebaseMessagesTopicNew);
    ''';
  }
}
