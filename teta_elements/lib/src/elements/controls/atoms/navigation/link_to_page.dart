/*import 'package:feather_icons_flutter/feather_icons_flutter.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:nil/nil.dart';

// Project imports:
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/page.dart';
import 'package:mobile_editor/src/models/project.dart';
import 'package:mobile_editor/src/models/variable.dart';

class LinkToPageControl extends StatefulWidget {
  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final Function(String, String) callBack;
  final Function(Map<String, dynamic>) callBackParameters;
  LinkToPageControl({
    Key? key,
    required this.prj,
    required this.page,
    required this.node,
    required this.callBack,
    required this.callBackParameters,
  }) : super(key: key);

  @override
  _LinkToPageControlState createState() => _LinkToPageControlState();
}

class _LinkToPageControlState extends State<LinkToPageControl> {
  String? id;
  String? dropdown;
  PageObject? pageObject;
  Map<String, dynamic> map = Map();

  @override
  void initState() {
    super.initState();
    id = widget.node.linkToPage;
    try {
      pageObject = widget.prj.pages!.firstWhere((element) => element.id == id);
      dropdown = pageObject!.name;
      if (widget.node.paramsToSend != null) map = widget.node.paramsToSend!;
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
          Padding(
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
                    final old = widget.node.linkToPage;
                    pageObject = widget.prj.pages!
                        .firstWhere((element) => element.name == newValue);
                    setState(() {
                      dropdown = newValue;
                      id = pageObject!.id;
                    });
                    widget.callBack(pageObject!.id!, old!);
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
          if (pageObject != null && pageObject!.scaffold!.params != [])
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Color(0xFFFFBF2F),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pageObject!.scaffold!.params!
                          .map(
                            (variable) => element(variable),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 8,
                      bottom: 8,
                    ),
                    color: Colors.black,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(FeatherIcons.database,
                            size: 16, color: Color(0xFFFFBF2F)),
                        const Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: const CText(
                            'Paga Params',
                            size: 12,
                            color: Palette.yellow,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget element(VariableObject variable) {
    final List<VariableObject> list = [];
    if (widget.page.scaffold!.params != null)
      list.addAll(widget.page.scaffold!.params!);
    if (widget.page.scaffold!.states != null)
      list.addAll(widget.page.scaffold!.states!);

    final List<DatasetObject> listDataset = [];
    if (widget.page.scaffold!.params != null)
      listDataset.add(
        DatasetObject(
          name: "Parameters",
          map: widget.page.scaffold!.params!
              .map((e) => {"${e.name}": e.get})
              .toList(),
        ),
      );
    if (widget.page.scaffold!.states != null)
      listDataset.add(
        DatasetObject(
          name: "States",
          map: widget.page.scaffold!.states!
              .map((e) => {"${e.name}": e.get})
              .toList(),
        ),
      );
    if (widget.page.scaffold!.dataset != null)
      listDataset.addAll(widget.page.scaffold!.dataset!);
    String? dropdown;
    try {
      dropdown = map["${variable.id}"]["label"];
    } catch (e) {}
    String? dropdownDataset;
    try {
      dropdownDataset = map["${variable.id}"]["dataset"];
    } catch (e) {}
    return StatefulBuilder(
      builder: (context, setState) {
        List<Map<String, dynamic>> listSecondDropwdown = [];
        if (dropdownDataset != null) {
          try {
            listSecondDropwdown = listDataset
                .firstWhere((element) => element.name == dropdownDataset)
                .map as List<Map<String, String>>;
            listSecondDropwdown.forEach((element) {
              print(element.keys);
            });
          } catch (e) {
            print(e);
          }
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CText(
                  variable.name!,
                  size: 12,
                  color: Palette.textPrimary,
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                    value: dropdownDataset ?? null,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownDataset = newValue;
                      });
                    },
                    isDense: true,
                    isExpanded: true,
                    items: listDataset
                        .map((e) => '${e.name}')
                        .toSet()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CText(value, size: 16),
                      );
                    }).toList()),
              ),
              if (dropdownDataset != null)
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                      value: dropdown ?? null,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            dropdown = newValue;
                          });
                          map["${variable.id}"] = {
                            "dataset": dropdownDataset,
                            "label": newValue,
                          };
                          widget.callBackParameters(map);
                        }
                      },
                      isDense: true,
                      isExpanded: true,
                      items: listSecondDropwdown.first.keys
                          .map((key) => '$key')
                          .toSet()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CText(value, size: 16),
                        );
                      }).toList()),
                ),
            ],
          ),
        );
      },
    );
  }
}
*/
