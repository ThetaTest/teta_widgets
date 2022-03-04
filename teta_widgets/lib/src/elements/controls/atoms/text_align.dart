// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_widgets/src/elements/controls/atoms/widgets/selection_tab.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextAlignControls extends StatefulWidget {
  const TextAlignControls({
    Key? key,
    required this.node,
    required this.textStyle,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final FTextStyle textStyle;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  TextAlignControlsState createState() => TextAlignControlsState();
}

class TextAlignControlsState extends State<TextAlignControls> {
  FTextAlign? textAlign;
  TextAlign? aligns;

  @override
  void initState() {
    textAlign = widget.textStyle.textAlign ?? FTextAlign();
    aligns = textAlign!.get;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: CText(
                'Text Align',
                color: Palette.white,
                size: 12,
                weight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                SelectionTab(
                  isSelected: widget.textStyle.textAlign!.get == TextAlign.left,
                  onTap: () {
                    final old = FTextStyle.fromJson(widget.textStyle.toJson());

                    widget.textStyle.textAlign!
                        .update(value: 'l', context: context);
                    widget.callBack(widget.textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.format_align_left,
                ),
                SelectionTab(
                  isSelected:
                      widget.textStyle.textAlign!.get == TextAlign.center,
                  onTap: () {
                    final old = FTextStyle.fromJson(widget.textStyle.toJson());

                    widget.textStyle.textAlign!
                        .update(value: 'c', context: context);
                    widget.callBack(widget.textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.format_align_center,
                ),
                SelectionTab(
                  isSelected:
                      widget.textStyle.textAlign!.get == TextAlign.right,
                  onTap: () {
                    final old = FTextStyle.fromJson(widget.textStyle.toJson());

                    widget.textStyle.textAlign!
                        .update(value: 'r', context: context);
                    widget.callBack(widget.textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.format_align_right,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
