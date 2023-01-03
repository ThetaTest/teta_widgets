// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/http_params.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class FirebaseAnalyticsLogShareControl extends StatelessWidget {
  const FirebaseAnalyticsLogShareControl({
    required this.prj,
    required this.page,
    required this.node,
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
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
            node: node,
            value: action.firebaseAnalyticsContentType ?? FTextTypeInput(),
            page: page,
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
            node: node,
            value: action.firebaseAnalyticsItemId ?? FTextTypeInput(),
            page: page,
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
            node: node,
            value: action.firebaseAnalyticsMethod ?? FTextTypeInput(),
            page: page,
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
