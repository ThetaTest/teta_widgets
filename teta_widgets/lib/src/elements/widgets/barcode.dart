// Flutter imports:
import 'package:barcode_widget/barcode_widget.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WBarcode extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WBarcode(
    final Key? key, {
    required this.node,
    required this.data,
    required this.barcodeType,
    required this.width,
    required this.height,
    required this.fill,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput data;
  final FTextTypeInput barcodeType;
  final FSize width;
  final FSize height;
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
      child: BarcodeWidget(
        barcode: Barcode.fromType(
          EnumToString.fromString(
                BarcodeType.values,
                barcodeType.get(params, states, dataset, forPlay, loop),
              ) ??
              BarcodeType.Code128,
        ),
        data: data.get(params, states, dataset, forPlay, loop),
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        color: HexColor(fill.getHexColor(context))
            .withOpacity(fill.levels?.first.opacity ?? 1),
      ),
    );
  }
}
