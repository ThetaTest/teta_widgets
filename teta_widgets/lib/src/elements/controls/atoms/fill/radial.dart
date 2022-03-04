// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/bloc.dart';
import 'package:teta_core/src/design_system/buttons/button.dart';
import 'package:teta_core/src/design_system/dialogs/color_picker.dart';
import 'package:teta_core/src/design_system/hex_color.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class RadialFillControl extends StatefulWidget {
  const RadialFillControl({
    required this.title,
    required this.fill,
    required this.node,
    required this.isStyled,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final FFill fill;
  final String title;
  final bool isStyled;
  final CNode node;
  final Function(FFill, bool, FFill) callBack;

  @override
  ColorControlState createState() => ColorControlState();
}

class ColorControlState extends State<RadialFillControl> {
  String? value;
  bool isVisible = true;
  TextEditingController controller = TextEditingController();
  CNode? tempNode;
  bool isUpdated = false;
  String? tempColor;
  int selectedElementIndex = 0;
  Alignment? align;

  @override
  void initState() {
    controller.text = '${widget.fill.radius}';
    tempColor = widget.fill.levels?.first.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (context, state) {
        //updateState(state);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: double.maxFinite,
              height: 100,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: widget.fill.levels!
                      .map((e) => HexColor(e.color))
                      .toList(),
                  stops: widget.fill.levels!.map((e) => e.stop).toList(),
                  center: widget.fill.center!,
                  radius: widget.fill.radius!,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.topLeft,
                          '',
                          isPreview: true,
                        ),
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.topCenter,
                          '',
                          isPreview: true,
                        ),
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.topRight,
                          '',
                          isPreview: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.centerLeft,
                          '',
                          isPreview: true,
                        ),
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.center,
                          '',
                          isPreview: true,
                        ),
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.centerRight,
                          '',
                          isPreview: true,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.bottomLeft,
                          '',
                          isPreview: true,
                        ),
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.bottomCenter,
                          '',
                          isPreview: true,
                        ),
                        alignPositionIcon(
                          widget.fill.center!,
                          Alignment.bottomRight,
                          '',
                          isPreview: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CButton(
                      label: 'Center',
                      callback: () {
                        setState(() {
                          align = widget.fill.center;
                        });
                        showPickerAlign(widget.fill.center!, 'center');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CMiniTextField(
                    controller: controller,
                    placeholder: '${widget.fill.radius}',
                    hpadding: 4,
                    callBack: (radius) {
                      if (double.tryParse(radius) != null) {
                        final old = FFill().fromJson(widget.fill.toJson());
                        widget.fill.radius = double.parse(radius);
                        widget.callBack(widget.fill, false, old);
                      }
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: widget.fill.levels!
                  .map(
                    (e) => FillElement(
                      element: e,
                      fill: widget.fill,
                      index: widget.fill.levels!.indexOf(e),
                      node: widget.node,
                      callBackIndex: (index) {
                        setState(() {
                          selectedElementIndex = index;
                        });
                        showPicker();
                      },
                      callBack: (fill, old) {
                        widget.callBack(fill, false, old);
                      },
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CButton(
                label: 'Add Color',
                callback: () {
                  final old = FFill().fromJson(widget.fill.toJson());
                  widget.fill.levels!.add(
                    FFillElement(
                      color: 'ffffff',
                      stop: 1,
                    ),
                  );
                  widget.callBack(widget.fill, false, old);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future updateState(CNode node) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        tempColor = widget.fill.levels!.first.color;
      });
    } else {
      await updateState(node);
    }
  }

  void updateColor(Color color) {
    final old = FFill().fromJson(widget.fill.toJson());
    setState(() {
      widget.fill.levels![selectedElementIndex].color =
          color.value.toRadixString(16).substring(2, 8);
      isUpdated = true;
    });
    controller.text = color.value.toRadixString(16).substring(2, 8);
    widget.callBack(widget.fill, false, old);
  }

  void updatedPosition(Alignment align, String name) {
    final old = FFill().fromJson(widget.fill.toJson());
    if (name == 'center') widget.fill.center = align;
    widget.callBack(widget.fill, false, old);
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  void showPicker() {
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

  void showPickerAlign(
    Alignment align,
    String name,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF333333),
          title: const Text(''),
          content: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors:
                    widget.fill.levels!.map((e) => HexColor(e.color)).toList(),
                center: widget.fill.center!,
                radius: widget.fill.radius!,
                stops: widget.fill.levels!.map((e) => e.stop).toList(),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      alignPositionIcon(
                        align,
                        Alignment.topLeft,
                        name,
                        isPreview: false,
                      ),
                      alignPositionIcon(
                        align,
                        Alignment.topCenter,
                        name,
                        isPreview: false,
                      ),
                      alignPositionIcon(
                        align,
                        Alignment.topRight,
                        name,
                        isPreview: false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      alignPositionIcon(
                        align,
                        Alignment.centerLeft,
                        name,
                        isPreview: false,
                      ),
                      alignPositionIcon(
                        align,
                        Alignment.center,
                        name,
                        isPreview: false,
                      ),
                      alignPositionIcon(
                        align,
                        Alignment.centerRight,
                        name,
                        isPreview: false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      alignPositionIcon(
                        align,
                        Alignment.bottomLeft,
                        name,
                        isPreview: false,
                      ),
                      alignPositionIcon(
                        align,
                        Alignment.bottomCenter,
                        name,
                        isPreview: false,
                      ),
                      alignPositionIcon(
                        align,
                        Alignment.bottomRight,
                        name,
                        isPreview: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CButton(
              label: 'Close',
              callback: () {
                //setState(() => fill = pickerColor);
                Navigator.of(context, rootNavigator: true).pop(null);
              },
            ),
          ],
        );
      },
    );
  }

  Widget alignPositionIcon(
    Alignment alignNode,
    Alignment alignTarget,
    String name, {
    required bool isPreview,
  }) {
    return GestureDetector(
      onTap: () {
        if (isPreview) updatedPosition(alignTarget, name);
      },
      child: Container(
        width: isPreview ? 8 : 32,
        height: isPreview ? 8 : 32,
        decoration: BoxDecoration(
          color: alignTarget == alignNode
              ? Colors.white
              : isPreview
                  ? Colors.transparent
                  : Colors.white38,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class FillElement extends StatefulWidget {
  const FillElement({
    required this.element,
    required this.fill,
    required this.index,
    required this.node,
    required this.callBackIndex,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final FFill fill;
  final FFillElement element;
  final int index;
  final CNode node;
  final Function(int) callBackIndex;
  final Function(FFill, FFill) callBack;

  @override
  FillElementState createState() => FillElementState();
}

class FillElementState extends State<FillElement> {
  TextEditingController editingController = TextEditingController();
  TextEditingController stopController = TextEditingController();
  int? nodeId;
  bool? isUpdated;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    editingController.text = widget.element.color;
    stopController.text = '${widget.element.stop}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              editingController.text = widget.element.color;
              stopController.text = '${widget.element.stop}';
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: GestureDetector(
                onTap: () {
                  widget.callBackIndex(widget.index);
                },
                child: HoverWidget(
                  hoverChild: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: HexColor(widget.element.color),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onHover: (e) {},
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: HexColor(widget.element.color),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: CTextField(
                controller: editingController,
                placeholder: widget.element.color,
                hpadding: 4,
                onSubmitted: (text) {
                  final hexCode = text.replaceAll('#', '');
                  if (hexCode.length == 3) {
                    final hexColor =
                        RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                    if (hexColor.hasMatch(hexCode)) {
                      final old = FFill().fromJson(widget.fill.toJson());
                      widget.element.color = '$hexCode$hexCode';
                      widget.callBack(widget.fill, old);
                    }
                  }
                  if (hexCode.length == 6) {
                    final hexColor =
                        RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                    if (hexColor.hasMatch(hexCode)) {
                      final old = FFill().fromJson(widget.fill.toJson());
                      widget.element.color = hexCode;
                      widget.callBack(widget.fill, old);
                    }
                  }
                },
                callBack: (text) {
                  final hexCode = text.replaceAll('#', '');
                  if (hexCode.length == 3) {
                    final hexColor =
                        RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                    if (hexColor.hasMatch(hexCode)) {
                      final old = FFill().fromJson(widget.fill.toJson());
                      widget.element.color = '$hexCode$hexCode';
                      widget.callBack(widget.fill, old);
                    }
                  }
                  if (hexCode.length == 6) {
                    final hexColor =
                        RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                    if (hexColor.hasMatch(hexCode)) {
                      final old = FFill().fromJson(widget.fill.toJson());
                      widget.element.color = hexCode;
                      widget.callBack(widget.fill, old);
                    }
                  }
                },
              ),
            ),
            Expanded(
              child: CTextField(
                controller: stopController,
                placeholder: '${widget.element.stop}',
                hpadding: 4,
                callBack: (text) {
                  if (double.tryParse(text) != null) {
                    final old = FFill().fromJson(widget.fill.toJson());
                    widget.element.stop = double.parse(text);
                    widget.callBack(widget.fill, old);
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.fill.levels!.length > 2) {
                  final old = FFill().fromJson(widget.fill.toJson());
                  widget.fill.levels!.remove(widget.element);
                  widget.callBack(widget.fill, old);
                }
              },
              child: HoverWidget(
                hoverChild: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      size: 24,
                      color: (widget.fill.levels!.length > 2)
                          ? Colors.white
                          : Colors.white24,
                    ),
                  ),
                ),
                onHover: (e) {},
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      size: 24,
                      color: (widget.fill.levels!.length > 2)
                          ? Colors.white
                          : Colors.white24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
