// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

class WMarker extends StatelessWidget {
  /// Returns a Icon widget in Teta
  const WMarker(
    final Key? key, {
    required this.state,
    required this.latitude,
    required this.longitude,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput latitude;
  final FTextTypeInput longitude;

  @override
  Widget build(final BuildContext context) {
    return ChildConditionBuilder(
      ValueKey(state.toKey),
      state: state,
      child: child,
    );
  }
}
