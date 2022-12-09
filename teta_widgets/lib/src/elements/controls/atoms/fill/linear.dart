// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/fill/widgets/gradient_swiper_control.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class LinearFillControl extends StatefulWidget {
  /// Constructor
  const LinearFillControl({
    required this.title,
    required this.fill,
    required this.node,
    required this.isStyled,
    required this.callBack,
    final Key? key,
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
  bool isUpdated = false;
  String? tempColor;
  int selectedElementIndex = 0;
  Alignment? align;

  @override
  void initState() {
    tempColor = widget.fill.levels!.first.color;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
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
                      .map((final e) => HexColor(e.color))
                      .toList(),
                  stops: widget.fill.levels!.map((final e) => e.stop).toList(),
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
            if (kDebugMode)
              const SizedBox(
                width: double.maxFinite,
                height: 300,
                child: GradientSwiper(
                  child: TParagraph('Ciao'),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CButton(
                      label: 'Begin',
                      isPrimary: false,
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
                      isPrimary: false,
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
                    (final e) => FillElement(
                      element: e,
                      fill: widget.fill,
                      index: widget.fill.levels?.indexOf(e) ?? 0,
                      node: widget.node,
                      callBackIndex: (final index, final controller) {
                        setState(() {
                          selectedElementIndex = index;
                        });
                        _showPicker(controller);
                      },
                      callBack: (final fill, final old) {
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

  void _updateColor(final Color color) {
    final old = FFill().fromJson(widget.fill.toJson());
    setState(() {
      widget.fill.levels![selectedElementIndex].color =
          color.value.toRadixString(16).substring(2, 8);
      isUpdated = true;
    });
    widget.callBack(widget.fill, false, old);
  }

  void _updatedPosition(final Alignment align, final String name) {
    final old = FFill().fromJson(widget.fill.toJson());
    if (name == 'begin') widget.fill.begin = align;
    if (name == 'end') widget.fill.end = align;
    widget.callBack(widget.fill, false, old);
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  void _showPicker(final TextEditingController controller) {
    showDialog<void>(
      context: context,
      builder: (final context) {
        return ColorPickerDialog(
          context: context,
          color: tempColor!,
          fill: widget.fill,
          callback: (final color) {
            controller.text = color.value.toRadixString(16).substring(2, 8);
            _updateColor(color);
          },
        );
      },
    );
  }

  void _showPickerAlign(
    final Alignment align,
    final String name,
  ) {
    showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF333333),
          content: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.fill.levels!
                    .map((final e) => HexColor(e.color))
                    .toList(),
                begin: widget.fill.begin!,
                end: widget.fill.end!,
                stops: widget.fill.levels!.map((final e) => e.stop).toList(),
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
    final Alignment alignNode,
    final Alignment alignTarget,
    final String name,
    final bool isPreview,
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
    required this.element,
    required this.fill,
    required this.index,
    required this.node,
    required this.callBackIndex,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FFill fill;
  final FFillElement element;
  final int index;
  final CNode node;
  final Function(int, TextEditingController) callBackIndex;
  final Function(FFill, FFill) callBack;

  @override
  FillElementState createState() => FillElementState();
}

class FillElementState extends State<FillElement> {
  TextEditingController editingController = TextEditingController();
  TextEditingController stopController = TextEditingController();
  TextEditingController opacityController = TextEditingController();
  int? nodeId;
  bool? isUpdated;

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    editingController.text = widget.element.color;
    stopController.text = '${widget.element.stop}';
    opacityController.text = '${widget.element.opacity}';
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
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
            Expanded(
              flex: 2,
              child: TContainer(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Palette.bgTertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: GestureDetector(
                        onTap: () {
                          widget.callBackIndex(widget.index, editingController);
                        },
                        child: HoverWidget(
                          hoverChild: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: HexColor(widget.element.color),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onHover: (final e) {},
                          child: Container(
                            width: 32,
                            height: 32,
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
                        onSubmitted: (final text) {
                          final hexCode = text.replaceAll('#', '');
                          if (hexCode.length == 3) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill.toJson());
                              widget.element.color = '$hexCode$hexCode';
                              widget.callBack(widget.fill, old);
                            }
                          }
                          if (hexCode.length == 6) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill.toJson());
                              widget.element.color = hexCode;
                              widget.callBack(widget.fill, old);
                            }
                          }
                        },
                        callBack: (final text) {
                          final hexCode = text.replaceAll('#', '');
                          if (hexCode.length == 3) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill.toJson());
                              widget.element.color = '$hexCode$hexCode';
                              widget.callBack(widget.fill, old);
                            }
                          }
                          if (hexCode.length == 6) {
                            final hexColor =
                                RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
                            if (hexColor.hasMatch(hexCode)) {
                              final old =
                                  FFill().fromJson(widget.fill.toJson());
                              widget.element.color = hexCode;
                              widget.callBack(widget.fill, old);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(Grid.small),
            Expanded(
              child: CTextField(
                controller: opacityController,
                placeholder: '${widget.element.opacity}',
                hpadding: 4,
                callBack: (final text) {
                  if (double.tryParse(text) != null) {
                    final old = FFill().fromJson(widget.fill.toJson());
                    widget.element.opacity = double.parse(text);
                    widget.callBack(widget.fill, old);
                  }
                },
              ),
            ),
            const Gap(Grid.small),
            Expanded(
              child: CTextField(
                controller: stopController,
                placeholder: '${widget.element.stop}',
                hpadding: 4,
                callBack: (final text) {
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
                onHover: (final e) {},
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
