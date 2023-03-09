// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/teta_core.dart';

import '../../features/border.dart';
import '../../features/border_style.dart';
import '../../features/fill.dart';
import '../../features/margins.dart';
// Project imports:
import 'fill.dart';
import 'margins.dart';

class BordersControl extends StatefulWidget {
  const BordersControl({
    required this.borders,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FBorder borders;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  BordersControlState createState() => BordersControlState();
}

class BordersControlState extends State<BordersControl> {
  bool isLinked = true;

  @override
  void initState() {
    isLinked = widget.borders.style?.style == BorderStyle.solid;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<int>>(
      builder: (final context, final state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TParagraph(
                    'Borders',
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLinked = !isLinked;
                      });
                      final old = widget.borders.toJson();
                      widget.borders.style ??=
                          FBorderStyle(style: BorderStyle.none);
                      if (widget.borders.style!.style == BorderStyle.none) {
                        widget.borders.style!.style = BorderStyle.solid;
                      } else {
                        widget.borders.style!.style = BorderStyle.none;
                      }
                      widget.callBack(widget.borders.toJson(), old);
                    },
                    child: HoverWidget(
                      hoverChild: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Icon(
                          isLinked ? FeatherIcons.eye : FeatherIcons.eyeOff,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onHover: (final e) {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Icon(
                          isLinked ? FeatherIcons.eye : FeatherIcons.eyeOff,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Margins(
              title: 'Width',
              value: widget.borders.width ?? FMargins(),
              callBack: (final width, final old) {
                final old = widget.borders.toJson();
                widget.borders.width ??= FMargins();
                widget.borders.width = FMargins.fromJson(width);
                widget.callBack(widget.borders.toJson(), old);
              },
            ),
            const Gap(Grid.medium),
            FillControl(
              callBack: (final fill, final isStyled, final old) {
                final old = widget.borders.toJson();
                widget.borders.fill = fill;
                widget.callBack(widget.borders.toJson(), old);
              },
              fill: widget.borders.fill ?? FFill(),
              isImageEnabled: false,
              isNoneEnabled: false,
              type: FillTypeControlType.onlySolid,
            ),
          ],
        );
      },
    );
  }
}
