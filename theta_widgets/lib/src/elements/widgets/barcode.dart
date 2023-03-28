// Flutter imports:
import 'package:barcode_widget/barcode_widget.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WBarcode extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WBarcode(
    final Key? key, {
    required this.state,
    required this.data,
    required this.barcodeType,
    required this.width,
    required this.height,
    required this.fill,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput data;
  final FTextTypeInput barcodeType;
  final FSize width;
  final FSize height;
  final FFill fill;

  @override
  Widget build(final BuildContext context) {
    final tempOpacity = fill.levels?.first.opacity ?? 1;
    final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;
    return TetaWidget(
      state: state,
      child: BarcodeWidget(
        barcode: Barcode.fromType(
          EnumToString.fromString(
                BarcodeType.values,
                barcodeType.get(
                  state.params,
                  state.states,
                  state.dataset,
                  state.forPlay,
                  state.loop,
                  context,
                ),
              ) ??
              BarcodeType.Code128,
        ),
        data: data.get(
          state.params,
          state.states,
          state.dataset,
          state.forPlay,
          state.loop,
          context,
        ),
        width: width.get(
          context: context,
          isWidth: true,
          forPlay: state.forPlay,
        ),
        height: height.get(
          context: context,
          isWidth: false,
          forPlay: state.forPlay,
        ),
        color: HexColor(fill.getHexColor(context)).withOpacity(opacity),
      ),
    );
  }
}
