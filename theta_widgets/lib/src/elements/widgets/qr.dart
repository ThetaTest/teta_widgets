// Flutter imports:
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WQR extends StatelessWidget {
  /// Returns a QR widget in Teta
  const WQR(
    final Key? key, {
    required this.state,
    required this.content,
    required this.image,
    required this.withImage,
    required this.size,
    required this.fill,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput content;
  final FTextTypeInput image;
  final bool withImage;
  final FSize size;
  final FFill fill;

  @override
  Widget build(final BuildContext context) {
    final tempOpacity = fill.levels?.first.opacity ?? 1;
    final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;
    return TetaWidget(
      state: state,
      child: QrImage(
        data: content.get(
          state.params,
          state.states,
          state.dataset,
          state.forPlay,
          state.loop,
          context,
        ),
        gapless: false,
        size: size.get(
          context: context,
          isWidth: true,
          forPlay: state.forPlay,
        ),
        foregroundColor:
            HexColor(fill.getHexColor(context)).withOpacity(opacity),
        embeddedImage: withImage
            ? NetworkImage(
                image.get(
                  state.params,
                  state.states,
                  state.dataset,
                  state.forPlay,
                  state.loop,
                  context,
                ),
              )
            : null,
      ),
    );
  }
}
