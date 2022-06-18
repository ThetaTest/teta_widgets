// Dart imports:
// ignore_for_file: public_member_api_docs

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/size.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class FontSizeControl extends StatefulWidget {
  const FontSizeControl({
    required this.node,
    required this.textStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FTextStyle textStyle;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  FontSizeState createState() => FontSizeState();
}

class FontSizeState extends State<FontSizeControl> {
  int? nodeId;
  bool? isUpdated;
  TextEditingController controller = TextEditingController();
  Timer? searchOnStoppedTyping;

  @override
  void initState() {
    nodeId = widget.node.nid;
    controller.text = '${widget.textStyle.fontSize?.get()}';
    super.initState();
  }

  void onChangeHandler(final FTextStyle value, final FTextStyle old) {
    const duration = Duration(milliseconds: 400);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel());
    }
    setState(
      () => searchOnStoppedTyping = Timer(
        duration,
        () => setValue(value, old),
      ),
    );
  }

  void setValue(final FTextStyle value, final FTextStyle old) {
    widget.callBack(
      value.toJson(),
      old.toJson(),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              controller.text = '${widget.textStyle.fontSize!.get()}';
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const THeadline3(
                'Font Size',
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      final old = widget.textStyle;
                      widget.textStyle.fontSize!.unit = SizeUnit.pixel;
                      onChangeHandler(widget.textStyle, old);
                    },
                    child: unitIcon(
                      unit: SizeUnit.pixel,
                      unitFromNode: widget.textStyle.fontSize!.unit,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final old = widget.textStyle;
                      widget.textStyle.fontSize!.unit = SizeUnit.width;
                      onChangeHandler(widget.textStyle, old);
                    },
                    child: unitIcon(
                      unit: SizeUnit.width,
                      unitFromNode: widget.textStyle.fontSize!.unit,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final old = widget.textStyle;
                      widget.textStyle.fontSize!.unit = SizeUnit.height;
                      onChangeHandler(widget.textStyle, old);
                    },
                    child: unitIcon(
                      unit: SizeUnit.height,
                      unitFromNode: widget.textStyle.fontSize!.unit,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(Grid.small),
          CTextField(
            controller: controller,
            text: '${widget.textStyle.fontSize?.get()}',
            callBack: (final value) {
              final old = widget.textStyle;
              widget.textStyle.fontSize!.size = double.parse(value);
              onChangeHandler(widget.textStyle, old);
            },
          ),
        ],
      ),
    );
  }
}
