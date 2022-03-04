// Dart imports:
// ignore_for_file: public_member_api_docs

import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/index.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FontSizeControl extends StatefulWidget {
  const FontSizeControl({
    Key? key,
    required this.node,
    required this.textStyle,
    required this.callBack,
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
    controller.text = '${widget.textStyle.fontSize?.get}';
    super.initState();
  }

  void onChangeHandler(FTextStyle value, FTextStyle old) {
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

  void setValue(FTextStyle value, FTextStyle old) {
    widget.callBack(
      value.toJson(),
      old.toJson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              controller.text = '${widget.textStyle.fontSize!.get}';
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: CText(
              'Font Size',
              color: Palette.white,
              size: 12,
              weight: FontWeight.w500,
            ),
          ),
          CTextField(
            controller: controller,
            text: '${widget.textStyle.fontSize?.get}',
            callBack: (value) {
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
