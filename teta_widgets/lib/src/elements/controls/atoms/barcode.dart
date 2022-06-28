// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:barcode/barcode.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class BarcodeControl extends StatefulWidget {
  const BarcodeControl({
    required this.node,
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  BarcodeControlState createState() => BarcodeControlState();
}

class BarcodeControlState extends State<BarcodeControl> {
  int? nodeId;
  bool? isUpdated;

  @override
  void initState() {
    nodeId = widget.node.nid;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const THeadline3(
            'Barcode Type',
          ),
          CDropdown(
            value: EnumToString.fromString(
                      BarcodeType.values,
                      widget.value.value ?? 'Code128',
                    ) !=
                    null
                ? widget.value.value
                : 'Code128',
            items: EnumToString.toList(BarcodeType.values),
            onChange: (final newValue) {
              final old = widget.value;
              widget.value.value = newValue;
              widget.callBack(widget.value, old);
            },
          ),
        ],
      ),
    );
  }
}
