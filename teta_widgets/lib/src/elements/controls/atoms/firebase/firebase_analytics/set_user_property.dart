// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:theta_models/theta_models.dart';

class FirebaseAnalyticsLogSetUserPropertyControl extends StatelessWidget {
  const FirebaseAnalyticsLogSetUserPropertyControl({
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final FActionElement action;
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
            value: action.firebaseAnalyticsName ?? FTextTypeInput(),
            title: 'name',
            callBack: (final value, final old) {
              action.firebaseAnalyticsName = value;
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
            value: action.firebaseAnalyticsValue ?? FTextTypeInput(),
            title: 'value',
            callBack: (final value, final old) {
              action.firebaseAnalyticsValue = value;
              callback();
            },
          ),
        ),
      ],
    );
  }
}
