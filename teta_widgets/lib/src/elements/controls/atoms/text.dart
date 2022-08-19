// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
import 'package:enum_to_string/enum_to_string.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/design_system/textfield/multi_line_textfield.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextControl extends StatefulWidget {
  const TextControl({
    required this.node,
    required this.value,
    required this.page,
    required this.title,
    required this.callBack,
    this.isSubControl = false,
    this.remove,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final PageObject page;
  final String title;
  final bool isSubControl;
  final Function(FTextTypeInput, FTextTypeInput) callBack;
  final Function()? remove;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<TextControl> {
  int? nodeId;
  bool? isUpdated;
  String? text;
  late TextEditingController controller;
  late TextEditingController keyController;
  String databaseName = '';
  String databaseAttribute = '';
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;
  bool isChanged = false;

  @override
  void initState() {
    controller = TextEditingController();
    keyController = TextEditingController();
    nodeId = widget.node.nid;
    try {
      text = widget.value.value ?? '';
      controller.text = text!;
      typeOfInput = widget.value.type!;
      if (widget.value.datasetName != null) {
        databaseName = widget.value.datasetName!;
      }
      databaseAttribute = widget.value.datasetAttr!;
    } catch (_) {}
    keyController.text = widget.value.mapKey ?? '';
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    Logger.printMessage(
      '''${(BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj.config?.appLanguage?.languages}''',
    );
    final index = widget.page.datasets.indexWhere(
      (final element) => element.getName == widget.value.datasetName,
    );
    final dataset =
        index != -1 ? widget.page.datasets[index] : DatasetObject.empty();
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            if (mounted) {
              nodeId = state.first.nid;
              controller.text = widget.value.value ?? '';
            }
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!widget.isSubControl)
                  THeadline3(
                    widget.title,
                  ),
                if (widget.isSubControl)
                  BounceSmall(
                    onTap: () {
                      if (widget.remove != null) {
                        // ignore: prefer_null_aware_method_calls
                        widget.remove!();
                      }
                    },
                    child: HoverWidget(
                      hoverChild: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: const Icon(
                          FeatherIcons.minus,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onHover: (final e) {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: const Icon(
                          FeatherIcons.minus,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                CDropdownForType(
                  value: widget.value.type == FTextTypeEnum.dataset
                      ? 'dataset'
                      : widget.value.type == FTextTypeEnum.state
                          ? 'state'
                          : widget.value.type == FTextTypeEnum.param
                              ? 'param'
                              : widget.value.type == FTextTypeEnum.combined
                                  ? 'combined'
                                  : widget.value.type == FTextTypeEnum.languages
                                      ? 'languages'
                                      : 'text',
                  items: [
                    'text',
                    'param',
                    'state',
                    'dataset',
                    if (!widget.isSubControl) 'combined',
                    'languages',
                  ],
                  onChange: (final value) {
                    var typeOfInput = FTextTypeEnum.text;
                    if (value == 'text') {
                      typeOfInput = FTextTypeEnum.text;
                    }
                    if (value == 'param') {
                      typeOfInput = FTextTypeEnum.param;
                    }
                    if (value == 'state') {
                      typeOfInput = FTextTypeEnum.state;
                    }
                    if (value == 'dataset') {
                      typeOfInput = FTextTypeEnum.dataset;
                    }
                    if (value == 'combined') {
                      typeOfInput = FTextTypeEnum.combined;
                    }
                    if (value == 'languages') {
                      typeOfInput = FTextTypeEnum.languages;
                    }
                    final old = widget.value;
                    final newValue = widget.value..type = typeOfInput;
                    widget.callBack(newValue, old);
                  },
                ),
              ],
            ),
            if (widget.value.type == FTextTypeEnum.text)
              Column(
                children: [
                  CMultiLinesTextField(
                    //text: text,
                    controller: controller,
                    callBack: (final value) {
                      setState(() {
                        isChanged = true;
                      });
                    },
                    onSubmitted: (final value) {
                      value.replaceAll(r'\', r'\\');
                      final old = widget.value;
                      widget.value.value = value;
                      widget.callBack(widget.value, old);
                      setState(() {
                        isChanged = false;
                      });
                    },
                  ),
                  const Gap(Grid.small),
                  CButton(
                    label: 'Confirm',
                    isPrimary: isChanged,
                    callback: () {
                      final old = widget.value;
                      widget.value.value =
                          controller.text.replaceAll(r'\', r'\\');
                      widget.callBack(widget.value, old);
                      setState(() {
                        isChanged = false;
                      });
                    },
                  ),
                ],
              ),
            if (widget.value.type == FTextTypeEnum.param)
              Column(
                children: [
                  CDropdown(
                    value: widget.page.params
                            .map((final e) => e.name)
                            .contains(widget.value.paramName)
                        ? widget.value.paramName
                        : null,
                    items: widget.page.params.map((final e) => e.name).toList(),
                    onChange: (final newValue) {
                      final old = widget.value;
                      widget.value.paramName = newValue;
                      widget.callBack(widget.value, old);
                    },
                  ),
                  if ((widget.page.params
                              .firstWhereOrNull(
                                (final element) =>
                                    element.name == widget.value.paramName,
                              )
                              ?.type ??
                          VariableType.int) ==
                      VariableType.json)
                    CTextField(
                      controller: keyController,
                      title: 'Map Key',
                      callBack: (final key) {
                        final old = widget.value;
                        widget.value.mapKey = key;
                        widget.callBack(widget.value, old);
                      },
                    ),
                ],
              ),
            if (widget.value.type == FTextTypeEnum.state)
              Column(
                children: [
                  CDropdown(
                    value: widget.page.states
                            .map((final e) => e.name)
                            .contains(widget.value.stateName)
                        ? widget.value.stateName
                        : null,
                    items: widget.page.states.map((final e) => e.name).toList(),
                    onChange: (final newValue) {
                      final old = widget.value;
                      widget.value.stateName = newValue;
                      widget.callBack(widget.value, old);
                    },
                  ),
                  if (widget.page.states
                          .firstWhereOrNull(
                            (final element) =>
                                element.name == widget.value.stateName,
                          )
                          ?.type ==
                      VariableType.json)
                    CMiniTextField(
                      text: widget.value.mapKey,
                      title: 'Map Key',
                      callBack: (final key) {
                        final old = widget.value;
                        widget.value.mapKey = key;
                        widget.callBack(widget.value, old);
                      },
                    ),
                ],
              ),
            if (widget.value.type == FTextTypeEnum.languages)
              CDropdown(
                value: widget.value.keyTranslator,
                items: ((BlocProvider.of<FocusProjectBloc>(context).state
                                as ProjectLoaded)
                            .prj
                            .config
                            ?.appLanguage
                            ?.terms ??
                        <String, dynamic>{})
                    .entries
                    .map((final e) => e.key)
                    .toList(),
                onChange: (final value) {
                  final old = widget.value;
                  widget.value.keyTranslator = value;
                  widget.callBack(widget.value, old);
                  setState(() {});
                },
              ),
            if (widget.value.type == FTextTypeEnum.dataset &&
                widget.page.datasets.isNotEmpty)
              CDropdown(
                value: widget.page.datasets
                        .map((final e) => e.getName)
                        .where((final element) => element != 'null')
                        .contains(widget.value.datasetName)
                    ? widget.value.datasetName
                    : null,
                items: widget.page.datasets
                    .map((final e) => e.getName)
                    .where((final element) => element != 'null')
                    .toList(),
                onChange: (final newValue) {
                  setState(() {
                    databaseName = newValue!;
                  });
                  final old = widget.value;
                  widget.value.datasetName = newValue;
                  widget.callBack(widget.value, old);
                },
              ),
            if (widget.value.type == FTextTypeEnum.dataset &&
                widget.value.datasetName != null)
              Padding(
                padding: EI.smT,
                child: CDropdown(
                  value: (dataset.getMap.isNotEmpty
                              ? dataset.getMap.first
                              : <String, dynamic>{})
                          .keys
                          .toSet()
                          .contains(widget.value.datasetAttr)
                      ? widget.value.datasetAttr
                      : null,
                  items: (dataset.getMap.isNotEmpty
                          ? dataset.getMap.first
                          : <String, dynamic>{})
                      .keys
                      .toSet()
                      .toList(),
                  onChange: (final newValue) {
                    setState(() {
                      databaseAttribute = newValue!;
                    });
                    final old = widget.value;
                    widget.value.datasetAttr = newValue;
                    widget.callBack(widget.value, old);
                  },
                ),
              ),
            if (widget.value.type == FTextTypeEnum.combined)
              TContainer(
                decoration: BoxDecoration(
                  borderRadius: BR(8),
                  color: Palette.bgTertiary,
                ),
                padding: EI.smA,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const THeadline3('Combination'),
                        Row(
                          children: [
                            BounceSmall(
                              onTap: () {
                                editChildrenAlert(context);
                              },
                              child: HoverWidget(
                                hoverChild: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.list,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                onHover: (final e) {},
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.list,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            BounceSmall(
                              onTap: () {
                                final old = widget.value;
                                widget.value.combination ??= [];
                                widget.value.combination!.add(FTextTypeInput());
                                widget.callBack(widget.value, old);
                              },
                              child: HoverWidget(
                                hoverChild: Container(
                                  padding: const EdgeInsets.all(4),
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
                                onHover: (final e) {},
                                child: Container(
                                  padding: const EdgeInsets.all(4),
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
                          ],
                        ),
                      ],
                    ),
                    for (var element
                        in widget.value.combination ?? <FTextTypeInput>[])
                      TextControl(
                        node: widget.node,
                        value: element,
                        page: widget.page,
                        title: '',
                        isSubControl: true,
                        callBack: (final value, final old) {
                          final old = widget.value;
                          element = value;
                          widget.callBack(widget.value, old);
                        },
                        remove: () {
                          final old = widget.value;
                          widget.value.combination?.remove(element);
                          widget.callBack(widget.value, old);
                        },
                      ),
                  ],
                ),
              )
            else
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(Grid.medium),
                  const TDetailLabel('Convert to:'),
                  Padding(
                    padding: EI.smT,
                    child: CDropdown(
                      value: EnumToString.convertToString(
                        widget.value.resultType,
                        camelCase: true,
                      ),
                      items: EnumToString.toList(
                        ResultTypeEnum.values,
                        camelCase: true,
                      ).toList(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.value;
                          final type = EnumToString.fromString(
                            ResultTypeEnum.values,
                            newValue,
                            camelCase: true,
                          );
                          widget.value.resultType = type!;
                          widget.callBack(widget.value, old);
                        }
                      },
                    ),
                  ),
                  if (widget.value.resultType == ResultTypeEnum.dateTime)
                    Padding(
                      padding: EI.smT,
                      child: CDropdown(
                        value: widget.value.typeDateTimeFormat != null
                            ? EnumToString.convertToString(
                                widget.value.typeDateTimeFormat,
                                camelCase: true,
                              )
                            : null,
                        items: EnumToString.toList(
                          TypeDateTimeFormat.values,
                          camelCase: true,
                        ).toList(),
                        onChange: (final newValue) {
                          if (newValue != null) {
                            final old = widget.value;
                            final type = EnumToString.fromString(
                              TypeDateTimeFormat.values,
                              newValue,
                              camelCase: true,
                            );
                            widget.value.typeDateTimeFormat = type;
                            widget.callBack(widget.value, old);
                          }
                        },
                      ),
                    ),
                ],
              )
          ],
        );
      },
    );
  }

  void editChildrenAlert(
    final BuildContext context,
  ) {
    showDialog<void>(
      context: context,
      builder: (final ctxt) {
        return StatefulBuilder(
          builder: (final ctx, final setState) {
            return AlertDialog(
              backgroundColor: Palette.bgDialog,
              title: const THeadline2(
                'Change order',
              ),
              content: Container(
                constraints:
                    const BoxConstraints(minHeight: 300, maxHeight: 500),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Palette.bgTertiary,
                  borderRadius: BR(8),
                ),
                clipBehavior: Clip.hardEdge,
                child: ClipRect(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ReorderableListView(
                      shrinkWrap: true,
                      onReorder: (final oldIndex, final newIndex) async {
                        final old = widget.value;
                        setState(() {
                          var defIndex = newIndex;
                          if (newIndex > oldIndex) {
                            defIndex -= 1;
                          }
                          final items =
                              widget.value.combination!.removeAt(oldIndex);
                          widget.value.combination!.insert(defIndex, items);
                          widget.callBack(widget.value, old);
                        });
                      },
                      children: [
                        for (int i = 0;
                            i < (widget.value.combination?.length ?? 0);
                            i++)
                          Padding(
                            key: ValueKey('Reord Element $i'),
                            padding: const EdgeInsets.only(bottom: 4),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Palette.bgGrey,
                                borderRadius: BR(8),
                              ),
                              child: ListTile(
                                key: ValueKey('Element $i'),
                                title: THeadline3(
                                  'Element $i',
                                ),
                                textColor: Palette.txtPrimary,
                                tileColor: Palette.bgGrey,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
