// ignore_for_file: public_member_api_docs, file_names

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class BorderRadiusControl extends StatefulWidget {
  const BorderRadiusControl({
    Key? key,
    required this.node,
    required this.borderRadius,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final FBorderRadius borderRadius;
  final Function(List<dynamic>, List<dynamic>) callBack;

  @override
  BorderRadiusControlState createState() => BorderRadiusControlState();
}

class BorderRadiusControlState extends State<BorderRadiusControl> {
  int? nodeId;
  bool? isUpdated;
  List<double>? radius;
  List<TextEditingController> controllers = [];
  bool isLinked = true;

  @override
  void initState() {
    nodeId = widget.node.nid;
    radius = widget.borderRadius.radius;
    for (var i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
    }
    for (var i = 0; i < 4; i++) {
      controllers[i].text = '${radius![i]}';
    }
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
              radius = widget.borderRadius.radius;
              for (var i = 0; i < 4; i++) {
                controllers[i].text = '${radius![i]}';
              }
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
                    const CText('Border Radius', color: Palette.white),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLinked = !isLinked;
                        });
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
                            isLinked ? Icons.link : Icons.link_off,
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
                            isLinked ? Icons.link : Icons.link_off,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CMiniTextField(
                      title: (!isLinked) ? 'T. L.' : 'ALL',
                      controller: controllers[0],
                      text: widget.borderRadius.radius![0].toString(),
                      hpadding: 4,
                      withSwipe: true,
                      callBack: (text) {
                        radius![0] = double.parse(text);
                        if (isLinked) {
                          radius![1] = double.parse(text);
                          controllers[1].text = text;
                          radius![2] = double.parse(text);
                          controllers[2].text = text;
                          radius![3] = double.parse(text);
                          controllers[3].text = text;
                        }
                        final old = FBorderRadius.fromJson(
                          widget.borderRadius.toJson(),
                        );
                        final bR = widget.borderRadius;
                        widget.callBack(
                          bR.update(value: radius!),
                          old.toJson(),
                        );
                      },
                    ),
                  ),
                  if (!isLinked)
                    Expanded(
                      child: CMiniTextField(
                        title: 'T. R.',
                        controller: controllers[1],
                        text: widget.borderRadius.radius![1].toString(),
                        hpadding: 4,
                        withSwipe: true,
                        callBack: (text) {
                          radius![1] = double.parse(text);
                          if (isLinked) {
                            radius![0] = double.parse(text);
                            controllers[0].text = text;
                            radius![2] = double.parse(text);
                            controllers[2].text = text;
                            radius![3] = double.parse(text);
                            controllers[3].text = text;
                          }
                          final old = FBorderRadius.fromJson(
                            widget.borderRadius.toJson(),
                          );
                          final bR = widget.borderRadius;
                          widget.callBack(
                            bR.update(value: radius!),
                            old.toJson(),
                          );
                        },
                      ),
                    ),
                  if (!isLinked)
                    Expanded(
                      child: CMiniTextField(
                        title: 'B. R.',
                        controller: controllers[2],
                        text: widget.borderRadius.radius![2].toString(),
                        hpadding: 4,
                        withSwipe: true,
                        callBack: (text) {
                          radius![2] = double.parse(text);
                          if (isLinked) {
                            radius![0] = double.parse(text);
                            controllers[0].text = text;
                            radius![1] = double.parse(text);
                            controllers[1].text = text;
                            radius![3] = double.parse(text);
                            controllers[3].text = text;
                          }
                          final old = FBorderRadius.fromJson(
                            widget.borderRadius.toJson(),
                          );
                          final bR = widget.borderRadius;
                          widget.callBack(
                            bR.update(value: radius!),
                            old.toJson(),
                          );
                        },
                      ),
                    ),
                  if (!isLinked)
                    Expanded(
                      child: CMiniTextField(
                        title: 'B. L.',
                        controller: controllers[3],
                        text: widget.borderRadius.radius![3].toString(),
                        hpadding: 4,
                        withSwipe: true,
                        callBack: (text) {
                          radius![3] = double.parse(text);
                          if (isLinked) {
                            radius![0] = double.parse(text);
                            controllers[0].text = text;
                            radius![1] = double.parse(text);
                            controllers[1].text = text;
                            radius![2] = double.parse(text);
                            controllers[2].text = text;
                          }
                          final old = FBorderRadius.fromJson(
                            widget.borderRadius.toJson(),
                          );
                          final bR = widget.borderRadius;
                          widget.callBack(
                            bR.update(value: radius!),
                            old.toJson(),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future updateState() async {
    setState(() {
      radius = widget.borderRadius.radius;
    });
    for (var i = 0; i < 4; i++) {
      controllers[i].text = '${radius![i]}';
    }
  }
}
