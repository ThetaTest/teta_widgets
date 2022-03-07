/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/page.dart';
import 'package:mobile_editor/src/models/project.dart';
import 'package:nil/nil.dart';

class ShpOnlyNavigationControl extends StatefulWidget {
  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final Function(String, String) callBack;
  final Function(Map<String, dynamic>) callBackParameters;

  ShpOnlyNavigationControl({
    Key? key,
    required this.prj,
    required this.page,
    required this.node,
    required this.callBack,
    required this.callBackParameters,
  }) : super(key: key);

  @override
  _ShpOnlyNavigationControlState createState() =>
      _ShpOnlyNavigationControlState();
}

class _ShpOnlyNavigationControlState extends State<ShpOnlyNavigationControl> {
  String? id;
  String? dropdown;
  PageObject? pageObject;

  @override
  void initState() {
    super.initState();
    id = widget.node.linkToPage;
    try {
      pageObject = widget.prj.pages!.firstWhere((element) => element.id == id);
      dropdown = pageObject!.name;
    } catch (e) {
      pageObject = widget.prj.pages!.first;
      dropdown = pageObject!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: const CText(
              'Link to page',
              color: Palette.white,
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),

            // dropdown below..
            child: DropdownButton<String>(
                value: dropdown ?? widget.prj.pages!.first.name,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    final old = widget.node.linkToPage!;
                    pageObject = widget.prj.pages!
                        .firstWhere((element) => element.name == newValue);
                    setState(() {
                      dropdown = newValue;
                      id = pageObject!.id!;
                    });
                    widget.callBack(pageObject!.id!, old);
                  }
                },
                isDense: true,
                isExpanded: true,
                items: widget.prj.pages!
                    .map((e) => e.name)
                    .map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CText(value!, size: 16),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
*/
