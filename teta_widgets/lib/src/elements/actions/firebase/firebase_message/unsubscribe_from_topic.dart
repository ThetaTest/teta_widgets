// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FActionFirebaseMessagesUnsubscribeTopic {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String? stateName,
    final FTextTypeInput? firebaseMessagesTopic,
  ) async {
    final firebaseMessagesTopicNew = firebaseMessagesTopic?.get(
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
              '(Firebase Messages- Unsubscribe To Topic- $firebaseMessagesTopicNew ) will be activated in your released app.',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
    final int pageId,
    final int loop,
    final FTextTypeInput? firebaseMessagesTopic,
  ) {
    final firebaseMessagesTopicNew = firebaseMessagesTopic
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
