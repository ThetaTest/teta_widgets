// Flutter imports:
// Package imports:
// ignore_for_file: import_of_legacy_library_into_null_safe, public_member_api_docs, lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_front_end/teta_front_end.dart';

class ComponentControl extends StatefulWidget {
  const ComponentControl({
    required this.callBack,
    required this.callBackParameters,
    final Key? key,
  }) : super(key: key);

  final Function(String, String) callBack;
  final Function(Map<String, dynamic>) callBackParameters;

  @override
  ComponentControlState createState() => ComponentControlState();
}

class ComponentControlState extends State<ComponentControl> {
  String? dropdown;
  PageObject? pageObject;
  List<PageObject> components = [];
  Map<String, dynamic> map = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    final pages = context.read<PagesCubit>().state;
    final nodeId = BlocProvider.of<FocusBloc>(context).state.first;
    final node = (context.read<PageCubit>().state as PageLoaded)
        .page
        .flatList
        .firstWhere((final element) => element.nid == nodeId);
    final name = node.body.attributes[DBKeys.componentName] as String? ?? '';
    components = pages.where((final element) => !element.isPage).toList();
    try {
      if (components.indexWhere((final element) => element.name == name) !=
          -1) {
        pageObject =
            components.firstWhere((final element) => element.name == name);
        dropdown = pageObject?.name;

        if (node.body.attributes[DBKeys.paramsToSend] != null) {
          map = node.body.attributes[DBKeys.paramsToSend]
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
            child: TParagraph(
              'Component',
            ),
          ),
          CDropdown(
            value: dropdown,
            items: components.map((final e) => e.name).toList(),
            onChange: (final String? newValue) {
              final nodeId = BlocProvider.of<FocusBloc>(context).state.first;
              final node = (context.read<PageCubit>().state as PageLoaded)
                  .page
                  .flatList
                  .firstWhere((final element) => element.nid == nodeId);

              if (newValue != null) {
                final old =
                    node.body.attributes[DBKeys.componentName] as String?;
                pageObject = components
                    .firstWhere((final element) => element.name == newValue);
                node.body.attributes[DBKeys.componentName] = pageObject!.name;
                setState(() {
                  dropdown = newValue;
                });
                widget.callBack(pageObject!.name, old ?? '');
              }
            },
          ),
          if (pageObject != null &&
              pageObject?.defaultParams != <VariableObject>[])
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
                    child: BlocBuilder<PageCubit, PageState>(
                      builder: (final context, final state) {
                        if (state is! PageLoaded) return const SizedBox();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: pageObject!.defaultParams
                              .map(
                                (final variable) => Element(
                                  variable: variable,
                                  page: state.page,
                                  map: map,
                                  callBackParameters: (final map) {
                                    try {
                                      final nodeId =
                                          context.read<FocusBloc>().state.first;
                                      final node = (context
                                              .read<PageCubit>()
                                              .state as PageLoaded)
                                          .page
                                          .flatList
                                          .firstWhere(
                                            (final element) =>
                                                element.nid == nodeId,
                                          );
                                      node.body
                                              .attributes[DBKeys.paramsToSend] =
                                          map;
                                      widget.callBackParameters(map);
                                    } catch (e) {
                                      Logger.printError(
                                        'Error in controls/navigation/component.dart, line 152, error: $e',
                                      );
                                    }
                                  },
                                ),
                              )
                              .toList(),
                        );
                      },
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
  List<DatasetObject> listDataset = [];
  String? dropdown;
  String? dropdownDataset;

  @override
  void initState() {
    super.initState();
    final state = context.read<PageCubit>().state as PageLoaded;
    final params = Map<String, dynamic>.fromEntries(
      state.page.defaultParams
          .where((final element) => widget.variable.type == element.type)
          .map((final e) => MapEntry<String, dynamic>(e.name, e.get)),
    );
    final states = Map<String, dynamic>.fromEntries(
      state.page.defaultStates
          .where((final element) => widget.variable.type == element.type)
          .map((final e) => MapEntry<String, dynamic>(e.name, e.get)),
    );
    listDataset = <DatasetObject>[
      DatasetObject(
        name: 'Parameters',
        map: [
          params,
        ],
      ),
      DatasetObject(
        name: 'States',
        map: [
          states,
        ],
      ),
      if (widget.variable.type == VariableType.string) ...state.datasets
    ];
    try {
      dropdown = widget.map[widget.variable.id]['label'] as String;
      dropdownDataset = widget.map[widget.variable.id]['dataset'] as String;
    } catch (e) {
      Logger.printError(
        'Error fetching component params in controls/atoms/navigation/component, error: $e',
      );
    }
  }

  @override
  Widget build(final BuildContext context) {
    var listSecondDropwdown = <Map<String, dynamic>>[];
    if (dropdownDataset != null) {
      final temp = listDataset.firstWhereOrNull(
        (final element) => element.getName == dropdownDataset,
      );
      if (temp != null) {
        listSecondDropwdown = temp.getMap;
      }
    }
    final items = listDataset
        .where(
          (final element) =>
              element.getMap.isNotEmpty || element.getName == 'Text',
        )
        .map((final e) => e.getName)
        .toSet()
        .toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TParagraph(
              widget.variable.name,
            ),
          ),
          CDropdown(
            value: dropdownDataset,
            items: items,
            onChange: (final String? newValue) {
              setState(() {
                dropdownDataset = newValue;
                listSecondDropwdown = [
                  ...listDataset
                      .where(
                        (final element) => element.getName == dropdownDataset,
                      )
                      .map(
                        (final e) =>
                            e.getMap.firstOrNull ?? <String, dynamic>{},
                      ),
                ];
              });
            },
          ),
          const Gap(Grid.small),
          if (dropdownDataset != null && dropdownDataset == 'Text')
            BlocBuilder<FocusBloc, List<int>>(
              builder: (final context, final state) {
                if (state.isNotEmpty) {
                  if (controller == null || nodeId != state.firstOrNull) {
                    nodeId = state.firstOrNull;
                    controller = TextEditingController()
                      ..text = widget.map[widget.variable.id] != null &&
                              widget.map[widget.variable.id]?['label'] != null
                          ? widget.map[widget.variable.id]['label'] as String
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
              value: listSecondDropwdown.firstOrNull != null
                  ? listSecondDropwdown.firstOrNull!.keys
                              .map((final key) => key)
                              .toSet()
                              .toList()
                              .contains(dropdown ?? '') ||
                          listSecondDropwdown
                              .map((final map) => map.keys.firstOrNull)
                              .whereNotNull()
                              .toSet()
                              .toList()
                              .contains(dropdown ?? '')
                      ? dropdown
                      : null
                  : null,
              items: listSecondDropwdown.firstOrNull != null
                  ? listSecondDropwdown.firstOrNull!.keys
                      .map((final key) => key)
                      .whereNotNull()
                      .toSet()
                      .toList()
                  : [],
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
  }
}
