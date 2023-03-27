// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

@Deprecated('This class is not used')
class FirebaseAnalyticsLogAppOpenControl extends StatelessWidget {
  const FirebaseAnalyticsLogAppOpenControl({
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final NodeGestureActionsElement action;
  final Function() callback;

  @override
  Widget build(final BuildContext context) {
    return const SizedBox();
  }
}
