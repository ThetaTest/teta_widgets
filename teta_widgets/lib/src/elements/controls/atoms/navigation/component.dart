// Flutter imports:
// Package imports:
// ignore_for_file: import_of_legacy_library_into_null_safe, public_member_api_docs, lines_longer_than_80_chars, avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class ComponentControl extends StatefulWidget {
  const ComponentControl({
    required this.prj,
    required this.page,
    required this.node,
    required this.callBack,
    required this.callBackParameters,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final Function(String, String) callBack;
  final Function(Map<String, dynamic>) callBackParameters;

  @override
  ComponentControlState createState() => ComponentControlState();
}

class ComponentControlState extends State<ComponentControl> {
  int? nodeId;
  String? name;
  String? dropdown;
  PageObject? pageObject;
  Map<String, dynamic> map = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    nodeId = widget.node.nid;
    name = widget.node.body.attributes[DBKeys.componentName] as String? ?? '';
    final components =
        widget.prj.pages!.where((final element) => !element.isPage).toList();
    try {
      if (components.indexWhere((final element) => element.name == name) !=
          -1) {
        pageObject =
            components.firstWhere((final element) => element.name == name);
        dropdown = pageObject?.name;
        if (widget.node.body.attributes[DBKeys.paramsToSend] != null) {
          map = widget.node.body.attributes[DBKeys.paramsToSend]
                  as Map<String, dynamic>? ??
              <String, dynamic>{};
        }
      }
    } catch (e) {
      if (components.isNotEmpty) {
        pageObject = components.where((final element) => !element.isPage).first;
        dropdown = pageObject?.name;
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    final components = (widget.prj.pages ?? <PageObject>[])
        .where((final element) => !element.isPage);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: THeadline3(
              'Component',
            ),
          ),
          CDropdown(
            value: dropdown,
            items: components.map((final e) => e.name).toList(),
            onChange: (final String? newValue) {
              if (newValue != null) {
                final old = widget.node.body.attributes[DBKeys.componentName]
                    as String?;
                pageObject = components
                    .firstWhere((final element) => element.name == newValue);
                setState(() {
                  dropdown = newValue;
                  name = '${pageObject!.id}';
                });
                widget.callBack(pageObject!.name, old ?? '');
              }
            },
          ),
          if (pageObject != null && pageObject?.params != <VariableObject>[])
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFFFBF2F),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pageObject!.params
                          .map(
                            (final variable) => Element(
                              variable: variable,
                              page: widget.page,
                              map: map,
                              callBackParameters: widget.callBackParameters,
                            ),
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
                      children: const [
                        Icon(
                          FeatherIcons.database,
                          size: 16,
                          color: Color(0xFFFFBF2F),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: TDetailLabel(
                            'Params',
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
}

class Element extends StatefulWidget {
  const Element({
    required this.variable,
    required this.page,
    required this.map,
    required this.callBackParameters,
    final Key? key,
  }) : super(key: key);

  final VariableObject variable;
  final PageObject page;
  final Map<String, dynamic> map;
  final Function(Map<String, dynamic>) callBackParameters;

  @override
  ElementState createState() => ElementState();
}

class ElementState extends State<Element> {
  TextEditingController? controller;
  int? nodeId;
  final List<VariableObject> list = [];
  final List<DatasetObject> listDataset = [
    DatasetObject(name: 'Text', map: [])
  ];
  String? dropdown;
  String? dropdownDataset;

  @override
  void initState() {
    super.initState();

    if (widget.page.params != <VariableObject>[]) {
      listDataset.add(
        DatasetObject(
          name: 'Parameters',
          map: widget.page.params
              .map((final e) => <String, dynamic>{e.name: e.get})
              .toList(),
        ),
      );
    }
    if (widget.page.states != <VariableObject>[]) {
      listDataset.add(
        DatasetObject(
          name: 'States',
          map: widget.page.states
              .map((final e) => <String, dynamic>{e.name: e.get})
              .toList(),
        ),
      );
    }
    listDataset.addAll(widget.page.datasets);
    try {
      dropdown = widget.map[widget.variable.id]['label'] as String;
    } catch (_) {}

    try {
      dropdownDataset = widget.map[widget.variable.id]['dataset'] as String;
    } catch (_) {}
  }

  @override
  Widget build(final BuildContext context) {
    return StatefulBuilder(
      builder: (final context, final setState) {
        var listSecondDropwdown = <Map<String, dynamic>>[];
        if (dropdownDataset != null) {
          try {
            listSecondDropwdown = listDataset
                .firstWhere(
                  (final element) => element.getName == dropdownDataset,
                )
                .getMap;
          } catch (_) {}
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: THeadline3(
                  widget.variable.name,
                ),
              ),
              CDropdown(
                value: dropdownDataset,
                items: listDataset
                    .where(
                      (final element) =>
                          element.getMap.isNotEmpty ||
                          element.getName == 'Text',
                    )
                    .map((final e) => e.getName)
                    .toSet()
                    .toList(),
                onChange: (final String? newValue) {
                  setState(() {
                    dropdownDataset = newValue;
                    listSecondDropwdown = [];
                    listSecondDropwdown.addAll(
                      listDataset
                          .firstWhere(
                            (final element) =>
                                element.getName == dropdownDataset,
                          )
                          .getMap,
                    );
                  });
                },
              ),
              const Gap(Grid.small),
              if (dropdownDataset != null && dropdownDataset == 'Text')
                BlocBuilder<FocusBloc, List<CNode>>(
                  builder: (final context, final state) {
                    if (state.isNotEmpty) {
                      if (controller == null || nodeId != state.first.nid) {
                        nodeId = state.first.nid;
                        controller = TextEditingController()
                          ..text = widget.map[widget.variable.id] != null &&
                                  widget.map[widget.variable.id]?['label'] !=
                                      null
                              ? widget.map[widget.variable.id]['label']
                                  as String
                              : '';
                      }
                    }
                    return CTextField(
                      //text: text,
                      controller: controller!,
                      placeholder: 'Write here',
                      callBack: (final value) {
                        widget.map[widget.variable.id ?? ''] = {
                          'dataset': dropdownDataset,
                          'label': value,
                        };
                        widget.callBackParameters(widget.map);
                      },
                    );
                  },
                ),
              if (dropdownDataset != null && dropdownDataset != 'Text')
                CDropdown(
                  value: listSecondDropwdown.first.keys
                              .map((final key) => key)
                              .toSet()
                              .toList()
                              .contains(dropdown ?? '') ||
                          listSecondDropwdown
                              .map((final map) => map.keys.first)
                              .toSet()
                              .toList()
                              .contains(dropdown ?? '')
                      ? dropdown
                      : null,
                  items:
                      dropdownDataset == 'States' || dropdownDataset == 'Params'
                          ? listSecondDropwdown
                              .map((final map) => map.keys.first)
                              .toSet()
                              .toList()
                          : listSecondDropwdown.first.keys
                              .map((final key) => key)
                              .toSet()
                              .toList(),
                  onChange: (final String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        dropdown = newValue;
                      });
                      widget.map[widget.variable.id ?? ''] = {
                        'dataset': dropdownDataset,
                        'label': newValue,
                      };
                      widget.callBackParameters(widget.map);
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
