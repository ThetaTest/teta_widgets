// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/buttons/button.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/design_system/textfield/multi_line_textfield.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:uuid/uuid.dart';

class PageParamsControl extends StatefulWidget {
  const PageParamsControl({
    Key? key,
    required this.node,
    required this.page,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final PageObject page;
  final Function(List<VariableObject>) callBack;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<PageParamsControl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CText(
              'Page Params',
              color: Palette.white,
              size: 16,
              weight: FontWeight.w500,
            ),
            GestureDetector(
              onTap: () {
                //widget.page.params.remove(null);
                //widget.page.params["Untitled ${widget.page.params.length}"] =
                //"";
                //widget.callBack();
                const pagePrefix = 'Param';
                var pageName = '';
                var index = 0;
                do {
                  index++;
                  pageName = '$pagePrefix $index';
                } while (widget.page.params
                        .indexWhere((element) => element.name == pageName) !=
                    -1);
                widget.page.params.add(
                  VariableObject(
                    id: const Uuid().v1(),
                    type: VariableType.string,
                    name: pageName,
                    defaultValue: '0',
                  ),
                );
                widget.callBack(widget.page.params);
              },
              child: HoverWidget(
                hoverChild: Padding(
                  padding: const EdgeInsets.all(4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                onHover: (e) {},
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: widget.page.params
              .map(
                (variable) => HoverWidget(
                  hoverChild: item(variable, onHover: true),
                  onHover: (e) {},
                  child: item(variable, onHover: false),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget item(
    VariableObject variable, {
    required bool onHover,
  }) {
    return GestureDetector(
      onTap: () {
        showAlert(context, widget.page, variable);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white,
            style: onHover ? BorderStyle.solid : BorderStyle.none,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              '${variable.name}: ${variable.defaultValue}',
              color: Palette.white,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CText(
                    EnumToString.convertToString(
                      variable.type,
                      camelCase: true,
                    ),
                    customColor: Colors.green,
                    size: 12,
                    weight: FontWeight.bold,
                  ),
                ),
                if (variable.doc != null)
                  Expanded(
                    child: CText(
                      '// ${variable.doc}',
                      customColor: Colors.white54,
                      size: 12,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(
    BuildContext context,
    PageObject page,
    VariableObject variable,
  ) {
    final nameController = TextEditingController()..text = variable.name;
    final defaultValueController = TextEditingController()
      ..text = variable.defaultValue!;
    final docValueController = TextEditingController()
      ..text = variable.doc ?? '';
    showDialog<void>(
      context: context,
      builder: (context) {
        var isNameUnique = true;
        var type = EnumToString.convertToString(variable.type, camelCase: true);
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF222222),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CText(
                    'Edit Parameter',
                    weight: FontWeight.bold,
                    customColor: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop(null);
                      widget.page.params.remove(variable);
                      widget.callBack(widget.page.states);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: 'This action cannot be undone',
                        child: HoverWidget(
                          hoverChild: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                          child: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                          onHover: (e) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 250,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CText('Name', size: 14, customColor: Colors.white),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CMiniTextField(
                          controller: nameController,
                          placeholder: 'Name',
                          color: Colors.white,
                          text: variable.name,
                          callBack: (text) {
                            if (page.params.indexWhere(
                                  (element) =>
                                      element.name.toLowerCase() ==
                                      text.toLowerCase(),
                                ) !=
                                -1) {
                              setState(() {
                                isNameUnique = false;
                              });
                            } else {
                              setState(() {
                                isNameUnique = true;
                              });
                              variable.name = text;
                            }
                          },
                        ),
                      ),
                      if (!isNameUnique)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.4),
                            border: Border.all(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const CText(
                            'Please provide a unique name',
                            color: Palette.white,
                            size: 14,
                          ),
                        ),
                      const CText(
                        'Type',
                        size: 14,
                        customColor: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // dropdown below..
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: const Color(0xFF222222),
                          ),
                          child: DropdownButton<String>(
                            value: type,
                            icon: const Icon(Icons.arrow_drop_down),
                            underline: const SizedBox(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                final tempType = EnumToString.fromString(
                                  VariableType.values,
                                  newValue,
                                  camelCase: true,
                                );
                                variable.type = tempType;
                                setState(() {
                                  type = newValue;
                                });
                              }
                            },
                            isDense: true,
                            isExpanded: true,
                            items: EnumToString.toList(
                              VariableType.values,
                              camelCase: true,
                            )
                                .where(
                              (element) =>
                                  (element == 'Int' ||
                                      element == 'Double' ||
                                      element == 'String' ||
                                      element == 'Json') ||
                                  kDebugMode,
                            )
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: CText(
                                  value,
                                  size: 16,
                                  customColor: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const CText(
                        'Default Value',
                        size: 14,
                        customColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CMiniTextField(
                          controller: defaultValueController,
                          placeholder: 'Default Value',
                          text: variable.defaultValue,
                          color: Colors.white,
                          callBack: (text) {
                            if (variable.type ==
                                VariableType.cameraController) {
                              if (int.tryParse(text) != null) {
                                variable.cameraIndex = int.tryParse(text) ?? 0;
                              }
                            }
                            variable.defaultValue = text;
                          },
                        ),
                      ),
                      const CText(
                        'Description',
                        size: 14,
                        customColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CMultiLinesTextField(
                          controller: docValueController,
                          placeholder: 'Description',
                          text: variable.doc,
                          color: Colors.white,
                          callBack: (text) {
                            variable.doc = text;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: CButton(
                    label: 'Close',
                    callback: () {
                      for (var i = 0; i < widget.page.params.length; i++) {
                        if (widget.page.params[i].id == variable.id) {
                          widget.page.params[i] = variable;
                        }
                      }
                      widget.callBack(widget.page.params);
                      Navigator.of(context, rootNavigator: true).pop(null);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
