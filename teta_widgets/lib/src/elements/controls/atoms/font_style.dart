// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/widgets/selection_tab.dart';
import 'package:teta_widgets/src/elements/features/font_style.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FontStyleControls extends StatefulWidget {
  const FontStyleControls({
    required this.node,
    required this.callBack,
    required this.textStyle,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FTextStyle textStyle;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  TextStyleControlsState createState() => TextStyleControlsState();
}

class TextStyleControlsState extends State<FontStyleControls> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: CText(
                'Font Style',
                color: Palette.white,
                size: 12,
                weight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                SelectionTab(
                  isSelected:
                      widget.textStyle.fontStyle!.get == FontStyle.normal,
                  onTap: () {
                    final old = FTextStyle.fromJson(widget.textStyle.toJson());
                    widget.textStyle.fontStyle = FFontStyle();
                    widget.callBack(widget.textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.title,
                ),
                SelectionTab(
                  isSelected:
                      widget.textStyle.fontStyle!.get == FontStyle.italic,
                  onTap: () {
                    final old = FTextStyle.fromJson(widget.textStyle.toJson());
                    widget.textStyle.fontStyle =
                        FFontStyle(style: FontStyle.italic);
                    widget.callBack(widget.textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.format_italic,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
