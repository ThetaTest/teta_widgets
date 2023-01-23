// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/widgets/selection_tab.dart';
import 'package:teta_widgets/src/elements/features/text_decoration.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextDecorationControl extends StatelessWidget {
  const TextDecorationControl({
    required this.textStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextStyle textStyle;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(bottom: 8),
            //   child: THeadline3(
            //     'Decoration',
            //   ),
            // ),
            Row(
              children: [
                SelectionTab(
                  isSelected:
                      textStyle.textDecoration?.get == TextDecoration.none,
                  onTap: () {
                    final old = FTextStyle.fromJson(textStyle.toJson());

                    final textDecoration = FTextDecoration();
                    textStyle.textDecoration = textDecoration;
                    callBack(textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.title,
                ),
                SelectionTab(
                  isSelected:
                      textStyle.textDecoration?.get == TextDecoration.underline,
                  onTap: () {
                    final old = FTextStyle.fromJson(textStyle.toJson());

                    final textDecoration = FTextDecoration(
                      textDecoration: TextDecoration.underline,
                    );
                    textStyle.textDecoration = textDecoration;
                    callBack(textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.format_underline,
                ),
                SelectionTab(
                  isSelected: textStyle.textDecoration?.get ==
                      TextDecoration.lineThrough,
                  onTap: () {
                    final old = FTextStyle.fromJson(textStyle.toJson());

                    final textDecoration = FTextDecoration(
                      textDecoration: TextDecoration.lineThrough,
                    );
                    textStyle.textDecoration = textDecoration;
                    callBack(textStyle.toJson(), old.toJson());
                  },
                  icon: Icons.format_strikethrough,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
