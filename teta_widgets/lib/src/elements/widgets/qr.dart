// Flutter imports:
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WQR extends StatelessWidget {
  /// Returns a QR widget in Teta
  const WQR(
    final Key? key, {
    required this.node,
    required this.content,
    required this.image,
    required this.withImage,
    required this.size,
    required this.fill,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput content;
  final FTextTypeInput image;
  final bool withImage;
  final FSize size;
  final FFill fill;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: QrImage(
        data: content.get(
          params,
          states,
          dataset,
          forPlay,
          loop,
        ),
        gapless: false,
        size: size.get(context: context, isWidth: true),
        foregroundColor: HexColor(fill.getHexColor(context))
            .withOpacity(fill.levels?.first.opacity ?? 1),
        embeddedImage: withImage
            ? NetworkImage(
                image.get(
                  params,
                  states,
                  dataset,
                  forPlay,
                  loop,
                ),
              )
            : null,
      ),
    );
  }
}
