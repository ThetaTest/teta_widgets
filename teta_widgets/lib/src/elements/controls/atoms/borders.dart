// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hovering/hovering.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill.dart';
import 'package:teta_widgets/src/elements/controls/atoms/margins.dart';
import 'package:teta_widgets/src/elements/features/border.dart';
import 'package:teta_widgets/src/elements/features/border_style.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class BordersControl extends StatefulWidget {
  const BordersControl({
    Key? key,
    required this.node,
    required this.borders,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final FBorder borders;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callBack;

  @override
  BordersControlState createState() => BordersControlState();
}

class BordersControlState extends State<BordersControl> {
  int? nodeId;
  bool? isUpdated;
  bool isLinked = true;

  @override
  void initState() {
    nodeId = widget.node.nid;
    isLinked = widget.borders.style?.style == BorderStyle.solid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: BlocBuilder<FocusBloc, List<CNode>>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CText('Borders', color: Palette.white),
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
                        onHover: (e) {},
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
                node: widget.node,
                title: 'Width',
                value: widget.borders.width ?? FMargins(),
                callBack: (width, old) {
                  final old = widget.borders.toJson();
                  widget.borders.width ??= FMargins();
                  widget.borders.width!.margins = width;
                  widget.callBack(widget.borders.toJson(), old);
                },
              ),
              FillControl(
                node: widget.node,
                callBack: (fill, isStyled, old) {
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
      ),
    );
  }
}
