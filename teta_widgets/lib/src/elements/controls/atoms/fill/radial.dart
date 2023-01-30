// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class RadialFillControl extends StatefulWidget {
  const RadialFillControl({
    required this.title,
    required this.fill,
    required this.isStyled,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FFill fill;
  final String title;
  final bool isStyled;
  final Function(FFill, bool, FFill) callBack;

  @override
  ColorControlState createState() => ColorControlState();
}

class ColorControlState extends State<RadialFillControl> {
  TextEditingController controller = TextEditingController();
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
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<int>>(
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
                gradient: RadialGradient(
                  colors: widget.fill.levels!
                      .map((final e) => HexColor(e.color))
                      .toList(),
                  stops: widget.fill.levels!.map((final e) => e.stop).toList(),
                  center: widget.fill.center!,
                  radius: widget.fill.radius!,
                ),
                borderRadius: BorderRadius.circular(8),
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
                    callBack: (final radius) {
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
                    (final e) => FillElement(
                      element: e,
                      fill: widget.fill,
                      index: widget.fill.levels!.indexOf(e),
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

  Future _updateState(final CNode node) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        tempColor = widget.fill.levels!.first.color;
      });
    } else {
      await _updateState(node);
    }
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
    if (name == 'center') widget.fill.center = align;
    widget.callBack(widget.fill, false, old);
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  void _showPicker(final TextEditingController controller) {
    showDialog<void>(
      context: context,
      builder: (final context) {
        return ColorPickerDialog(
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

  void showPickerAlign(
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
              gradient: RadialGradient(
                colors: widget.fill.levels!
                    .map((final e) => HexColor(e.color))
                    .toList(),
                center: widget.fill.center!,
                radius: widget.fill.radius!,
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
    final Alignment alignNode,
    final Alignment alignTarget,
    final String name, {
    required final bool isPreview,
  }) {
    return GestureDetector(
      onTap: () {
        _updatedPosition(alignTarget, name);
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
    required this.callBackIndex,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FFill fill;
  final FFillElement element;
  final int index;
  final Function(int, TextEditingController) callBackIndex;
  final Function(FFill, FFill) callBack;

  @override
  FillElementState createState() => FillElementState();
}

class FillElementState extends State<FillElement> {
  TextEditingController editingController = TextEditingController();
  TextEditingController stopController = TextEditingController();
  TextEditingController opacityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editingController.text = widget.element.color;
    stopController.text = '${widget.element.stop}';
    opacityController.text = '${widget.element.opacity}';
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          editingController.text = widget.element.color;
          stopController.text = '${widget.element.stop}';
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
                  widget.callBackIndex(
                    widget.index,
                    editingController,
                  );
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
                  onHover: (final e) {},
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
                onSubmitted: (final text) {
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
                callBack: (final text) {
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
