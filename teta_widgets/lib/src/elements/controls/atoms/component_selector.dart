import 'package:dart_airtable/dart_airtable.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class ComponentSelector extends StatefulWidget {
  const ComponentSelector({
    super.key,
    required this.onParamsChanged,
    required this.pageToOpen,
    required this.paramsToSend,
  });

  final String? pageToOpen;
  final Map<String, dynamic>? paramsToSend;
  final Function(
    String? pageToOpen,
    Map<String, dynamic>? paramsToSend,
  ) onParamsChanged;

  @override
  State<ComponentSelector> createState() => _ComponentSelectorState();
}

class _ComponentSelectorState extends State<ComponentSelector> {
  final List<PageObject> projectComponents = [];
  PageObject? selectedPage;

  String? pageToOpen;
  Map<String, dynamic>? paramsToSend;

  @override
  void initState() {
    super.initState();
    pageToOpen = widget.pageToOpen;
    paramsToSend = widget.paramsToSend;

    final pagesCubit = context.read<PagesCubit>();
    projectComponents.addAll(
      pagesCubit.state.where((final elm) => !elm.isPage).toSet().toList(),
    );

    try {
      selectedPage = pagesCubit.state.firstWhereOrNull(
        (final elm) => elm.name == widget.pageToOpen,
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TParagraph('Select component'),
        const SizedBox(height: 8),
        CDropdown(
          value: selectedPage?.name,
          items: projectComponents.map((final e) => e.name).toList(),
          onChange: (final newValue) {
            if (newValue == null) return;

            setState(() {
              pageToOpen = newValue;
              selectedPage = projectComponents.firstWhere(
                (final e) => e.name == newValue,
              );
            });
            widget.onParamsChanged(pageToOpen, paramsToSend);
          },
        ),
        if (selectedPage != null && selectedPage!.defaultParams.isNotEmpty)
          selectedPage!.defaultParams.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                        ),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFFFBF2F),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: selectedPage!.defaultParams
                              .map(
                                (final e) => _PageParamsControl(
                                  variable: e,
                                  pageLoaded: pageLoaded,
                                  initialValue:
                                      paramsToSend ?? <String, dynamic>{},
                                  onParamsChanged: (final paramsToSend) {
                                    this.paramsToSend = paramsToSend;
                                    widget.onParamsChanged(
                                      pageToOpen,
                                      paramsToSend,
                                    );
                                  },
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
                        color: const Color(0xFF222222),
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
                              child: TActionLabel('Send Params'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      TDetailLabel(
                        'This page has no params',
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
      ],
    );
  }
}

class _PageParamsControl extends StatefulWidget {
  const _PageParamsControl({
    required this.variable,
    required this.pageLoaded,
    required this.initialValue,
    required this.onParamsChanged,
    final Key? key,
  }) : super(key: key);

  final VariableObject variable;
  final PageLoaded pageLoaded;
  final Map<String, dynamic> initialValue;
  final Function(Map<String, dynamic> paramsToSend) onParamsChanged;

  @override
  State<_PageParamsControl> createState() => __PageParamsControlState();
}

class __PageParamsControlState extends State<_PageParamsControl> {
  List<DatasetObject> listDataset = <DatasetObject>[];
  String? dropdownDataset;
  String? dropdown;
  List<Map<String, dynamic>> listSecondDropwdown = <Map<String, dynamic>>[];
  Map<String, dynamic> paramsToSend = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    paramsToSend = widget.initialValue;
    final params = Map<String, dynamic>.fromEntries(
      widget.pageLoaded.page.defaultParams
          .where((final element) => widget.variable.type == element.type)
          .map((final e) => MapEntry<String, dynamic>(e.name, e.get)),
    );
    final states = Map<String, dynamic>.fromEntries(
      widget.pageLoaded.page.defaultStates
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
      if (widget.variable.type == VariableType.string)
        ...widget.pageLoaded.datasets
    ];
    try {
      dropdown = widget.initialValue[widget.variable.id]?['label'] as String;
    } catch (e) {
      debugPrint('$e');
    }
    try {
      dropdownDataset =
          widget.initialValue[widget.variable.id]?['dataset'] as String;
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (dropdownDataset != null) {
      try {
        listSecondDropwdown.addAll(
          listDataset
              .firstWhere((final element) => element.getName == dropdownDataset)
              .getMap,
        );
      } catch (e) {
        Logger.printError(e.toString());
      }
    }
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
          if (listDataset
              .where((final element) => element.getMap.isNotEmpty)
              .isNotEmpty)
            CDropdown(
              value: listDataset
                      .where((final element) => element.getMap.isNotEmpty)
                      .map((final e) => e.getName)
                      .contains(dropdownDataset)
                  ? dropdownDataset
                  : null,
              items: listDataset
                  .where((final element) => element.getMap.isNotEmpty)
                  .map((final e) => e.getName)
                  .toSet()
                  .toList(),
              onChange: (final newValue) {
                if (mounted) {
                  setState(() {
                    dropdownDataset = newValue;
                    listSecondDropwdown = <Map<String, dynamic>>[];
                    listSecondDropwdown.addAll(
                      listDataset
                          .where(
                            (final element) =>
                                element.getName == dropdownDataset,
                          )
                          .map(
                            (final e) => e.getMap.first,
                          ),
                    );
                  });
                }
              },
            ),
          if (dropdownDataset != null && listSecondDropwdown.isNotEmpty)
            CDropdown(
              value: listSecondDropwdown.first.keys
                      .map((final key) => key)
                      .contains(dropdown)
                  ? dropdown
                  : null,
              items: listSecondDropwdown.first.keys.toList(),
              onChange: (final newValue) {
                if (newValue != null) {
                  if (mounted) {
                    setState(() {
                      dropdown = newValue;
                    });
                  }
                  if (widget.variable.id != null) {
                    paramsToSend[widget.variable.id!] = {
                      'dataset': dropdownDataset,
                      'label': newValue,
                    };
                  }
                  widget.onParamsChanged(paramsToSend);
                }
              },
            ),
        ],
      ),
    );
  }
}
