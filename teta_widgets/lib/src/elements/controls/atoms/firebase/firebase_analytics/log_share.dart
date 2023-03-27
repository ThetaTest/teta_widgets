// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_models/teta_models.dart';

class FirebaseAnalyticsLogShareControl extends StatelessWidget {
  const FirebaseAnalyticsLogShareControl({
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final NodeGestureActionsElement action;
  final Function() callback;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextControl(
            valueType: VariableType.string,
            value: action.firebaseAnalyticsContentType ?? FTextTypeInput(),
            title: 'contentType',
            callBack: (final value, final old) {
              action.firebaseAnalyticsContentType = value;
              callback();
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextControl(
            valueType: VariableType.string,
            value: action.firebaseAnalyticsItemId ?? FTextTypeInput(),
            title: 'itemId',
            callBack: (final value, final old) {
              action.firebaseAnalyticsItemId = value;
              callback();
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextControl(
            valueType: VariableType.string,
            value: action.firebaseAnalyticsMethod ?? FTextTypeInput(),
            title: 'method',
            callBack: (final value, final old) {
              action.firebaseAnalyticsMethod = value;
              callback();
            },
          ),
        ),
      ],
    );
  }
}
