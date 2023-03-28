// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WListTile extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WListTile(
    final Key? key, {
    required this.state,
    required this.value,
    required this.isThreeLine,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FTextTypeInput value;
  final bool isThreeLine;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: ListTile(
        isThreeLine: isThreeLine,
        leading:
            children.isNotEmpty ? children[0].toWidget(state: state) : null,
        trailing:
            children.length >= 3 ? children[2].toWidget(state: state) : null,
      ),
    );
  }
}
