// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/dialogs/color_picker.dart';
import 'package:teta_core/src/design_system/hex_color.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

//ignore: must_be_immutable
class SingleColorControl extends StatefulWidget {
  const SingleColorControl({
    Key? key,
    required this.title,
    required this.color,
    required this.node,
    required this.callBack,
  }) : super(key: key);

  final String title;
  final String color;
  final CNode node;
  final Function(String, String) callBack;

  @override
  SingleColorControlState createState() => SingleColorControlState();
}

class SingleColorControlState extends State<SingleColorControl> {
  int? nodeId;
  bool? isUpdated;
  String? value;
  bool isVisible = true;
  TextEditingController controller = TextEditingController();
  FFill? tempFill;
  String? tempColor;

  @override
  void initState() {
    nodeId = widget.node.nid;
    controller.text = widget.color;
    tempColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*if (tempColor != widget.color) {
      controller.text = widget.color;
      tempFill = widget.fill;
    }
    if (isUpdated) {
      controller.text = tempColor;
      isUpdated = false;
    }*/
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              controller.text = widget.color;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: BlocBuilder<FocusBloc, List<CNode>>(
        builder: (context, state) {
          //updateState(state);
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: GestureDetector(
                  onTap: () {
                    showPicker(context);
                  },
                  child: HoverWidget(
                    hoverChild: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: HexColor(widget.color),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                    onHover: (e) {},
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: HexColor(widget.color),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CMiniTextField(
                  controller: controller,
                  placeholder: tempColor,
                  hpadding: 4,
                  callBack: (text) {
                    final hexCode = text.replaceAll('#', '');
                    if (hexCode.length == 3) {
                      final hexColor =
                          RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                      if (hexColor.hasMatch(hexCode)) {
                        final old = widget.color;
                        final color = '$hexCode$hexCode';
                        widget.callBack(color, old);
                      }
                    }
                    if (hexCode.length == 6) {
                      final hexColor =
                          RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                      if (hexColor.hasMatch(hexCode)) {
                        final old = widget.color;
                        final color = hexCode;
                        widget.callBack(color, old);
                      }
                    }
                  },
                ),
              ),
              /*GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                      fill = fill;
                      widget.callBack("00$fill");
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white10,
                    ),
                    child: Center(
                      child: Icon(
                        isVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),*/
            ],
          );
        },
      ),
    );
  }

  Future updateState(CNode node) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        tempColor = widget.color;
      });
    } else {
      await updateState(node);
    }
  }

  void updateColor(Color color) {
    final old = widget.color;
    setState(() {
      tempColor = color.value.toRadixString(16).substring(2, 8);
      isUpdated = true;
    });
    final valueColor = color.value.toRadixString(16).substring(2, 8);
    controller.text = valueColor;
    widget.callBack(valueColor, old);
  }

  void showPicker(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return ColorPickerDialog(
          context: context,
          color: tempColor!,
          callback: updateColor,
        );
      },
    );
  }
}
