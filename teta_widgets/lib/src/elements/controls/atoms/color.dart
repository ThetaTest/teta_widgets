// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

//ignore: must_be_immutable
class SingleColorControl extends StatefulWidget {
  const SingleColorControl({
    required this.title,
    required this.color,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String title;
  final String color;
  final Function(String, String) callBack;

  @override
  SingleColorControlState createState() => SingleColorControlState();
}

class SingleColorControlState extends State<SingleColorControl> {
  bool isVisible = true;
  TextEditingController controller = TextEditingController();
  FFill? tempFill;
  String? tempColor;

  @override
  void initState() {
    controller.text = widget.color;
    tempColor = widget.color;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    /*if (tempColor != widget.color) {
      controller.text = widget.color;
      tempFill = widget.fill;
    }
    if (isUpdated) {
      controller.text = tempColor;
      isUpdated = false;
    }*/
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
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
                  onHover: (final e) {},
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
                callBack: (final text) {
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
          ],
        );
      },
    );
  }

  Future updateState(final CNode node) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        tempColor = widget.color;
      });
    } else {
      await updateState(node);
    }
  }

  void updateColor(final Color color) {
    final old = widget.color;
    setState(() {
      tempColor = color.value.toRadixString(16).substring(2, 8);
    });
    final valueColor = color.value.toRadixString(16).substring(2, 8);
    controller.text = valueColor;
    widget.callBack(valueColor, old);
  }

  void showPicker(final BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (final context) {
        return ColorPickerDialog(
          color: tempColor!,
          fill: null,
          callback: updateColor,
        );
      },
    );
  }
}
