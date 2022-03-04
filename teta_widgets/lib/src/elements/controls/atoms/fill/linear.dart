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
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class LinearFillControl extends StatefulWidget {
  /// Constructor
  const LinearFillControl({
    Key? key,
    required this.title,
    required this.fill,
    required this.node,
    required this.isStyled,
    required this.callBack,
  }) : super(key: key);

  final FFill fill;
  final String title;
  final bool isStyled;
  final CNode node;
  final Function(FFill, bool, FFill) callBack;

  @override
  ColorControlState createState() => ColorControlState();
}

class ColorControlState extends State<LinearFillControl> {
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
    controller.text = widget.fill.get(context).levels!.first.color;
    tempColor = widget.fill.levels!.first.color;
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
                gradient: LinearGradient(
                  colors: widget.fill.levels!
                      .map((e) => HexColor(e.color))
                      .toList(),
                  stops: widget.fill.levels!.map((e) => e.stop).toList(),
                  begin: widget.fill.begin!,
                  end: widget.fill.end!,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.topLeft,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.topCenter,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.topRight,
                              '',
                              true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.centerLeft,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.center,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.centerRight,
                              '',
                              true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.bottomLeft,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.bottomCenter,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.begin!,
                              Alignment.bottomRight,
                              '',
                              true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.topLeft,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.topCenter,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.topRight,
                              '',
                              true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.centerLeft,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.center,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.centerRight,
                              '',
                              true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.bottomLeft,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.bottomCenter,
                              '',
                              true,
                            ),
                            _alignPositionIcon(
                              widget.fill.end!,
                              Alignment.bottomRight,
                              '',
                              true,
                            ),
                          ],
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
                      label: 'Begin',
                      callback: () {
                        setState(() {
                          align = widget.fill.begin;
                        });
                        _showPickerAlign(widget.fill.begin!, 'begin');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: CButton(
                      label: 'End',
                      callback: () {
                        _showPickerAlign(widget.fill.end!, 'end');
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: (widget.fill.levels ?? <FFillElement>[])
                  .map(
                    (e) => FillElement(
                      element: e,
                      fill: widget.fill,
                      index: widget.fill.levels?.indexOf(e) ?? 0,
                      node: widget.node,
                      callBackIndex: (index) {
                        setState(() {
                          selectedElementIndex = index;
                        });
                        _showPicker();
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

  void _updateColor(Color color) {
    final old = FFill().fromJson(widget.fill.toJson());
    setState(() {
      widget.fill.levels![selectedElementIndex].color =
          color.value.toRadixString(16).substring(2, 8);
      isUpdated = true;
    });
    controller.text = color.value.toRadixString(16).substring(2, 8);
    widget.callBack(widget.fill, false, old);
  }

  void _updatedPosition(Alignment align, String name) {
    final old = FFill().fromJson(widget.fill.toJson());
    if (name == 'begin') widget.fill.begin = align;
    if (name == 'end') widget.fill.end = align;
    widget.callBack(widget.fill, false, old);
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  void _showPicker() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return ColorPickerDialog(
          context: context,
          color: tempColor!,
          callback: _updateColor,
        );
      },
    );
  }

  void _showPickerAlign(
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
              gradient: LinearGradient(
                colors:
                    widget.fill.levels!.map((e) => HexColor(e.color)).toList(),
                begin: widget.fill.begin!,
                end: widget.fill.end!,
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
                      _alignPositionIcon(align, Alignment.topLeft, name, false),
                      _alignPositionIcon(
                        align,
                        Alignment.topCenter,
                        name,
                        false,
                      ),
                      _alignPositionIcon(
                        align,
                        Alignment.topRight,
                        name,
                        false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _alignPositionIcon(
                        align,
                        Alignment.centerLeft,
                        name,
                        false,
                      ),
                      _alignPositionIcon(align, Alignment.center, name, false),
                      _alignPositionIcon(
                        align,
                        Alignment.centerRight,
                        name,
                        false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _alignPositionIcon(
                        align,
                        Alignment.bottomLeft,
                        name,
                        false,
                      ),
                      _alignPositionIcon(
                        align,
                        Alignment.bottomCenter,
                        name,
                        false,
                      ),
                      _alignPositionIcon(
                        align,
                        Alignment.bottomRight,
                        name,
                        false,
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

  Widget _alignPositionIcon(
    Alignment alignNode,
    Alignment alignTarget,
    String name,
    bool isPreview,
  ) {
    return GestureDetector(
      onTap: () {
        if (!isPreview) _updatedPosition(alignTarget, name);
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
  /// Constructor
  const FillElement({
    Key? key,
    required this.element,
    required this.fill,
    required this.index,
    required this.node,
    required this.callBackIndex,
    required this.callBack,
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
