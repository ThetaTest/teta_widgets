// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';

class WSpacer extends StatelessWidget {
  /// Returns a Spacer widget
  const WSpacer(
    final Key? key, {
    required this.state,
  }) : super(key: key);

  final TetaWidgetState state;

  @override
  Widget build(final BuildContext context) => const Spacer();
}
