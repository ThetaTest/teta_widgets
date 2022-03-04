/*import 'package:flutter/material.dart';

// Package imports:
import 'package:nil/nil.dart';

// Project imports:
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/page.dart';

class PageViewValueControl extends StatefulWidget {
  final CNode node;
  final PageObject page;
  final String title;
  final Function(FTextTypeInput, FTextTypeInput) callBack;
  PageViewValueControl({
    Key? key,
    required this.node,
    required this.page,
    required this.title,
    required this.callBack,
  }) : super(key: key);

  @override
  _PageViewControlControlState createState() => _PageViewControlControlState();
}

class _PageViewControlControlState extends State<PageViewValueControl> {
  String databaseName = "";
  String databaseAttribute = "";
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;

  @override
  void initState() {
    try {
      typeOfInput = widget.node.value!.type!;
      databaseName = widget.node.value!.datasetName!;
      databaseAttribute = widget.node.value!.datasetAttr!;
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                widget.title,
                color: Palette.white,
              ),
            ],
          ),
          if (widget.node.value?.type == FTextTypeEnum.dataset &&
              widget.page.scaffold?.dataset != null)
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: widget.node.value!.datasetName,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    databaseName = newValue!;
                  });
                  final old = widget.node.value;
                  widget.node.value!.datasetName = newValue;
                  widget.node.value!.datasetAttr = null;
                  widget.callBack(widget.node.value!, old!);
                },
                isDense: true,
                isExpanded: true,
                items: widget.page.scaffold!.dataset!
                    .map((e) => '${e.name}')
                    .where((element) => element != 'null')
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CText(value, size: 16),
                  );
                }).toList(),
              ),
            ),
          if (widget.node.value?.type == FTextTypeEnum.dataset &&
              widget.node.value!.datasetName != null &&
              widget.page.scaffold!.dataset != null &&
              widget.page.scaffold!.dataset!
                      .firstWhere((element) =>
                          element.name == widget.node.value!.datasetName)
                      .map !=
                  [{}])
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: widget.node.value!.datasetAttr,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    databaseAttribute = newValue!;
                  });
                  final old = widget.node.value;
                  widget.node.value!.datasetAttr = newValue;
                  widget.callBack(widget.node.value!, old!);
                },
                isDense: true,
                isExpanded: true,
                items: widget.page.scaffold!.dataset!
                    .firstWhere((element) =>
                        element.name == widget.node.value!.datasetName)
                    .map!
                    .first
                    .keys
                    .map((key) => '$key')
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CText(value, size: 16),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
*/
