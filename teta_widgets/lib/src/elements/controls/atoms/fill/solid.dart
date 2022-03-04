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

class SolidFillControl extends StatefulWidget {
  const SolidFillControl({
    Key? key,
    required this.title,
    required this.fill,
    this.color,
    required this.node,
    required this.isStyled,
    required this.callBack,
  }) : super(key: key);

  final FFill? fill;
  final String title;
  final String? color;
  final CNode node;
  final bool isStyled;
  final Function(FFill, bool, FFill) callBack;

  @override
  SolidFillControlState createState() => SolidFillControlState();
}

class SolidFillControlState extends State<SolidFillControl> {
  int? nodeId;
  bool? isUpdated;
  String? value;
  bool isVisible = true;
  TextEditingController controller = TextEditingController();
  FFill? tempFill;
  String? tempColor;

  @override
  void initState() {
    try {
      nodeId = widget.node.nid;
      if (widget.color != null) {
        controller.text = widget.color ?? '';
        tempColor = widget.color;
      } else {
        controller.text = widget.fill!.get(context).levels!.first.color;
        tempColor = widget.fill!.get(context).levels!.first.color;
      }
    } catch (_) {}
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
              if (widget.color != null) {
                controller.text = widget.color ?? '';
                tempColor = widget.color;
              } else {
                controller.text = widget.fill!.get(context).levels!.first.color;
                tempColor = widget.fill!.get(context).levels!.first.color;
              }
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: BlocBuilder<FocusBloc, List<CNode>>(
        builder: (context, state) {
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
                        color: HexColor(
                          widget.color != null
                              ? widget.color!
                              : widget.fill!.levels!.first.color,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                    onHover: (e) {},
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: HexColor(
                          widget.color != null
                              ? widget.color!
                              : widget.fill!.levels!.first.color,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
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
                  onSubmitted: (text) {
                    final hexCode = text.replaceAll('#', '');
                    if (hexCode.length == 3) {
                      final hexColor =
                          RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                      if (hexColor.hasMatch(hexCode)) {
                        final old = FFill().fromJson(widget.fill!.toJson());
                        widget.fill!.levels!.first.color = '$hexCode$hexCode';
                        widget.callBack(widget.fill!, false, old);
                      }
                    }
                    if (hexCode.length == 6) {
                      final hexColor =
                          RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                      if (hexColor.hasMatch(hexCode)) {
                        final old = FFill().fromJson(widget.fill!.toJson());
                        widget.fill!.levels!.first.color = hexCode;
                        widget.callBack(widget.fill!, false, old);
                      }
                    }
                  },
                  callBack: (text) {
                    final hexCode = text.replaceAll('#', '');
                    if (hexCode.length == 3) {
                      final hexColor =
                          RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                      if (hexColor.hasMatch(hexCode)) {
                        final old = FFill().fromJson(widget.fill!.toJson());
                        widget.fill!.levels!.first.color = '$hexCode$hexCode';
                        widget.callBack(widget.fill!, false, old);
                      }
                    }
                    if (hexCode.length == 6) {
                      final hexColor =
                          RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                      if (hexColor.hasMatch(hexCode)) {
                        final old = FFill().fromJson(widget.fill!.toJson());
                        widget.fill!.levels!.first.color = hexCode;
                        widget.callBack(widget.fill!, false, old);
                      }
                    }
                  },
                ),
              ),
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
        tempColor = widget.fill!.levels!.first.color;
      });
    } else {
      await updateState(node);
    }
  }

  void updateColor(Color color) {
    final old = FFill().fromJson(widget.fill!.toJson());
    setState(() {
      tempColor = color.value.toRadixString(16).substring(2, 8);
      isUpdated = true;
    });
    widget.fill!.levels!.first.color =
        color.value.toRadixString(16).substring(2, 8);
    controller.text = color.value.toRadixString(16).substring(2, 8);
    widget.callBack(widget.fill!, widget.isStyled, old);
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
