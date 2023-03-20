// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

// ignore_for_file: public_member_api_docs

class WLinearProgressIndicator extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WLinearProgressIndicator(
    final Key? key, {
    required this.state,
    required this.fill,
    required this.background,
  }) : super(key: key);

  final TetaWidgetState state;
  final FFill fill;
  final FFill background;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: LinearProgressIndicator(
        backgroundColor: HexColor(background.getHexColor(context)),
        valueColor: AlwaysStoppedAnimation<Color>(
          HexColor(fill.getHexColor(context)),
        ),
      ),
    );
  }
}
