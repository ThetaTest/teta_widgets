// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:enum_to_string/enum_to_string.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/design_system/textfield/multi_line_textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:uuid/uuid.dart';

class PageParamsControl extends StatefulWidget {
  const PageParamsControl({
    required this.node,
    required this.page,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final PageObject page;
  final Function(List<VariableObject>) callBack;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<PageParamsControl> {
  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const THeadline3(
              'Page Params',
            ),
            BounceSmall(
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
                } while (widget.page.params.indexWhere(
                      (final element) => element.name == pageName,
                    ) !=
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
                onHover: (final e) {},
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
                (final variable) => Row(
                  children: [
                    Expanded(
                      child: HoverWidget(
                        hoverChild: item(variable, onHover: true),
                        onHover: (final e) {},
                        child: item(variable, onHover: false),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 6,
                        right: 6,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          widget.page.params.remove(variable);
                          widget.callBack(widget.page.params);
                        },
                        child: Tooltip(
                          message: 'Delete. This action cannot be undone',
                          child: HoverWidget(
                            hoverChild: const Icon(
                              FeatherIcons.x,
                              color: Colors.red,
                              size: 20,
                            ),
                            onHover: (final e) {},
                            child: const Icon(
                              FeatherIcons.x,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget item(
    final VariableObject variable, {
    required final bool onHover,
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
            THeadline3(
              '${variable.name}: ${variable.defaultValue}',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TDetailLabel(
                    EnumToString.convertToString(
                      variable.type,
                      camelCase: true,
                    ),
                    color: Colors.green,
                  ),
                ),
                if (variable.doc != null)
                  Expanded(
                    child: TDetailLabel(
                      '// ${variable.doc}',
                      color: Colors.white54,
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
    final BuildContext context,
    final PageObject page,
    final VariableObject variable,
  ) {
    final nameController = TextEditingController()..text = variable.name;
    final defaultValueController = TextEditingController()
      ..text = variable.defaultValue!;
    final docValueController = TextEditingController()
      ..text = variable.doc ?? '';
    showDialog<void>(
      context: context,
      builder: (final context) {
        var isNameUnique = true;
        var type = EnumToString.convertToString(variable.type, camelCase: true);
        return StatefulBuilder(
          builder: (final context, final setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF222222),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TAlertTitle(
                    'Edit Parameter',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop(null);
                      widget.page.params.remove(variable);
                      widget.callBack(widget.page.params);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: 'This action cannot be undone',
                        child: HoverWidget(
                          hoverChild: const Icon(
                            FeatherIcons.trash,
                            size: 20,
                            color: Colors.red,
                          ),
                          child: const Icon(
                            FeatherIcons.trash,
                            size: 20,
                            color: Colors.white,
                          ),
                          onHover: (final e) {},
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
                      const THeadline3(
                        'Name',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CMiniTextField(
                          controller: nameController,
                          placeholder: 'Name',
                          text: variable.name,
                          backgroundColor: Palette.bgGrey,
                          callBack: (final text) {
                            if (page.params.indexWhere(
                                  (final element) =>
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
                          child: const TDetailLabel(
                            'Please provide a unique name',
                          ),
                        ),
                      const THeadline3(
                        'Type',
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
                            onChanged: (final String? newValue) {
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
                              (final element) =>
                                  (element == 'Int' ||
                                      element == 'Double' ||
                                      element == 'String' ||
                                      element == 'Audio controller') ||
                                  kDebugMode,
                            )
                                .map<DropdownMenuItem<String>>(
                                    (final String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: THeadline3(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const THeadline3(
                        'Default Value',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CMiniTextField(
                          controller: defaultValueController,
                          placeholder: 'Default Value',
                          text: variable.defaultValue,
                          backgroundColor: Palette.bgGrey,
                          callBack: (final text) {
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
                      const THeadline3(
                        'Description',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: CMultiLinesTextField(
                          controller: docValueController,
                          placeholder: 'Description',
                          text: variable.doc,
                          callBack: (final text) {
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
