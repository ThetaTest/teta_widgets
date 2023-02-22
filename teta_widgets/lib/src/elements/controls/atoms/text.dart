// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
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
import 'package:teta_widgets/teta_widgets.dart';

class TextControl extends StatefulWidget {
  const TextControl({
    required this.valueType,
    required this.value,
    required this.title,
    required this.callBack,
    this.withConvertTo = false,
    this.isSubControl = false,
    this.remove,
    final Key? key,
  }) : super(key: key);

  final VariableType? valueType;
  final FTextTypeInput value;
  final String title;
  final bool isSubControl;
  final bool withConvertTo;
  final Function(FTextTypeInput, FTextTypeInput) callBack;
  final Function()? remove;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<TextControl> with AfterLayoutMixin {
  TextEditingController controller = TextEditingController();
  TextEditingController keyController = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';
  String datasetSubListData = '';
  String datasetSubMapData = '';
  String datasetLength = '';

  FTextTypeEnum typeOfInput = FTextTypeEnum.text;
  bool isChanged = false;

  DatasetObject dataset = DatasetObject.empty();

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    setState(() {
      controller.text = widget.value.getValue(
        context,
        forPlay: false,
      );
      typeOfInput = widget.value.type!;
      if (widget.value.datasetName != null) {
        databaseName = widget.value.datasetName!;
      }
      final datasets = (context.read<PageCubit>().state as PageLoaded).datasets;
      final index = datasets.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      dataset = index != -1 ? datasets[index] : DatasetObject.empty();
      Logger.printMessage(
        'Datasets: $datasets, name: ${widget.value.datasetName}, index: $index',
      );
      if (widget.value.datasetAttr != null) {
        databaseAttribute = widget.value.datasetAttr!;
      }
      if (widget.value.datasetSubListData != null) {
        datasetSubListData = widget.value.datasetSubListData!;
      }
      if (widget.value.datasetSubMapData != null) {
        datasetSubMapData = widget.value.datasetSubMapData!;
      }
      if (widget.value.datasetLength != null) {
        datasetLength = widget.value.datasetLength!;
      }
      keyController.text = widget.value.mapKey ?? '';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<DeviceModeCubit, DeviceState>(
      listener: (final context, final device) {
        if (controller.text !=
            widget.value.getValue(
              context,
              forPlay: false,
            )) {
          controller.text = widget.value.getValue(
            context,
            forPlay: false,
          );
        }
      },
      child: BlocBuilder<DeviceModeCubit, DeviceState>(
        builder: (final context, final device) =>
            BlocBuilder<FocusBloc, List<int>>(
          builder: (final context, final focusState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (widget.value.type == FTextTypeEnum.text)
                          const DeviceIndicatorForControls(),
                        if (widget.value.type == FTextTypeEnum.text)
                          const Gap(Grid.small),
                        if (!widget.isSubControl)
                          TParagraph(
                            widget.title,
                          ),
                      ],
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
                    CDropdownCustom(
                      background: Colors.transparent,
                      value: widget.value.type == FTextTypeEnum.dataset
                          ? 'dataset'
                          : widget.value.type == FTextTypeEnum.state
                              ? 'state'
                              : widget.value.type == FTextTypeEnum.param
                                  ? 'param'
                                  : widget.value.type == FTextTypeEnum.combined
                                      ? 'combined'
                                      : widget.value.type ==
                                              FTextTypeEnum.languages
                                          ? 'languages'
                                          : 'text',
                      items: <DropdownCustomMenuItem<String>>[
                        DropdownCustomMenuItem(
                          value: 'text',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                FeatherIcons.type,
                                color: Palette.txtPrimary,
                                size: 22,
                              ),
                              Gap(Grid.small),
                              TDetailLabel('Text'),
                            ],
                          ),
                        ),
                        DropdownCustomMenuItem(
                          value: 'param',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                FeatherIcons.cpu,
                                color: Palette.txtPrimary,
                                size: 22,
                              ),
                              Gap(Grid.small),
                              TDetailLabel('Param'),
                            ],
                          ),
                        ),
                        DropdownCustomMenuItem(
                          value: 'state',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                FeatherIcons.cpu,
                                color: Palette.txtPrimary,
                                size: 22,
                              ),
                              Gap(Grid.small),
                              TDetailLabel('State'),
                            ],
                          ),
                        ),
                        DropdownCustomMenuItem(
                          value: 'dataset',
                          child: Row(
                            children: const [
                              Icon(
                                FeatherIcons.server,
                                color: Palette.txtPrimary,
                                size: 22,
                              ),
                              Gap(Grid.small),
                              TDetailLabel('Dataset'),
                            ],
                          ),
                        ),
                        if (!widget.isSubControl)
                          DropdownCustomMenuItem(
                            value: 'combined',
                            child: Row(
                              children: const [
                                Icon(
                                  FeatherIcons.server,
                                  color: Palette.txtPrimary,
                                  size: 22,
                                ),
                                Gap(Grid.small),
                                TDetailLabel('Combined'),
                              ],
                            ),
                          ),
                        DropdownCustomMenuItem(
                          value: 'languages',
                          child: Row(
                            children: const [
                              Icon(
                                FeatherIcons.globe,
                                color: Palette.txtPrimary,
                                size: 22,
                              ),
                              Gap(Grid.small),
                              TDetailLabel('Languages'),
                            ],
                          ),
                        ),
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
                        widget.value.type = typeOfInput;
                        widget.callBack(widget.value, old);
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
                          final old = widget.value;
                          widget.value.updateValue(
                            controller.text.replaceAll(r'\', r'\\'),
                            context,
                          );
                          widget.callBack(widget.value, old);
                          setState(() {
                            isChanged = false;
                          });
                        },
                        onSubmitted: (final value) {
                          value.replaceAll(r'\', r'\\');
                          final old = widget.value;
                          widget.value.updateValue(value, context);
                          widget.callBack(widget.value, old);
                          setState(() {
                            isChanged = false;
                          });
                        },
                      ),
                    ],
                  ),
                if (widget.value.type == FTextTypeEnum.param)
                  BlocBuilder<PageCubit, PageState>(
                    builder: (final context, final state) {
                      if (state is! PageLoaded) return const SizedBox();
                      final focusedNode = state.page.flatList.firstWhere(
                        (final element) => element.nid == focusState.first,
                      );
                      final variables = state.page.defaultParams
                          .where(
                            (final element) =>
                                widget.valueType != VariableType.dynamic &&
                                        focusedNode.globalType != NType.text
                                    ? element.type == widget.valueType
                                    : true,
                          )
                          .toList();
                      if (variables.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TDetailLabel(
                              'This attribute requires a ${widget.valueType!.name} variable.',
                              color: Palette.txtPrimary.withOpacity(0.6),
                            ),
                            const Gap(Grid.small),
                            CButton(
                              label: 'Add ${widget.valueType!.name} param',
                              isPrimary: true,
                              callback: () {
                                context
                                    .read<PageCubit>()
                                    .addParam(type: widget.valueType);
                              },
                            ),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TDetailLabel(
                            'It requires a ${widget.valueType!.name} variable.',
                            color: Palette.txtPrimary.withOpacity(0.6),
                          ),
                          const Gap(Grid.small),
                          CDropdown(
                            value: state.page.defaultParams
                                    .map((final e) => e.name)
                                    .contains(widget.value.paramName)
                                ? widget.value.paramName
                                : null,
                            items: variables.map((final e) => e.name).toList(),
                            onChange: (final newValue) {
                              final old = widget.value;
                              widget.value.paramName = newValue;
                              widget.callBack(widget.value, old);
                            },
                          ),
                          if ((state.page.defaultParams
                                      .firstWhereOrNull(
                                        (final element) =>
                                            element.name ==
                                            widget.value.paramName,
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
                      );
                    },
                  ),
                if (widget.value.type == FTextTypeEnum.state)
                  BlocBuilder<PageCubit, PageState>(
                    builder: (final context, final state) {
                      if (state is! PageLoaded) return const SizedBox();
                      final focusedNode = state.page.flatList.firstWhere(
                        (final element) => element.nid == focusState.first,
                      );
                      final variables = state.page.defaultStates
                          .where(
                            (final element) =>
                                widget.valueType != VariableType.dynamic &&
                                        focusedNode.globalType != NType.text
                                    ? element.type == widget.valueType
                                    : true,
                          )
                          .toList();
                      if (variables.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TDetailLabel(
                              'This attribute requires a ${widget.valueType!.name} variable.',
                              color: Palette.txtPrimary.withOpacity(0.6),
                            ),
                            const Gap(Grid.small),
                            CButton(
                              label: 'Add ${widget.valueType!.name} state',
                              isPrimary: true,
                              callback: () {
                                context
                                    .read<PageCubit>()
                                    .addState(type: widget.valueType);
                              },
                            ),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TDetailLabel(
                            'It requires a ${widget.valueType!.name} variable',
                            color: Palette.txtPrimary.withOpacity(0.6),
                          ),
                          const Gap(Grid.small),
                          CDropdown(
                            value: state.page.defaultStates
                                    .map((final e) => e.name)
                                    .contains(widget.value.stateName)
                                ? widget.value.stateName
                                : null,
                            items: variables.map((final e) => e.name).toList(),
                            onChange: (final newValue) {
                              final old = widget.value;
                              widget.value.stateName = newValue;
                              widget.callBack(widget.value, old);
                            },
                          ),
                          if (state.page.defaultStates
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
                      );
                    },
                  ),
                if (widget.value.type == FTextTypeEnum.languages)
                  BlocBuilder<ConfigCubit, ConfigState>(
                    builder: (final context, final state) {
                      if (state is! ConfigStateLoaded) return const SizedBox();
                      return CDropdown(
                        value: widget.value.keyTranslator,
                        items: state.config.appLanguage.terms.entries
                            .map((final e) => e.key)
                            .toList(),
                        onChange: (final value) {
                          final old = widget.value;
                          widget.value.keyTranslator = value;
                          widget.callBack(widget.value, old);
                          setState(() {});
                        },
                      );
                    },
                  ),
                if (widget.value.type == FTextTypeEnum.dataset)
                  BlocBuilder<PageCubit, PageState>(
                    builder: (final context, final state) {
                      if (state is! PageLoaded) return const SizedBox();
                      return CDropdown(
                        value: state.datasets
                                .map((final e) => e.getName)
                                .where((final element) => element != 'null')
                                .contains(widget.value.datasetName)
                            ? widget.value.datasetName
                            : null,
                        items: state.datasets
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
                      );
                    },
                  ),
                if (widget.valueType == VariableType.string ||
                    widget.valueType == VariableType.dynamic)
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
                            datasetLength = (dataset.getMap.isNotEmpty
                                    ? dataset.getMap
                                    : <dynamic>[])
                                .length
                                .toString();
                          });
                          final old = widget.value;
                          widget.value.datasetAttr = newValue;
                          widget.value.datasetLength =
                              (dataset.getMap.isNotEmpty
                                      ? dataset.getMap
                                      : <dynamic>[])
                                  .length
                                  .toString();
                          widget.value.datasetSubListData = '';
                          widget.value.datasetSubMapData = '';
                          widget.callBack(widget.value, old);
                        },
                      ),
                    ),
                //////////
                if (widget.valueType == VariableType.string ||
                    widget.valueType == VariableType.dynamic)
                  if (widget.value.type == FTextTypeEnum.dataset &&
                      widget.value.datasetName != null &&
                      widget.value.datasetAttr != null &&
                      dataset.isSubMap(widget.value.datasetAttr ?? ''))
                    Padding(
                      padding: EI.smT,
                      child: CDropdown(
                        value: (dataset.getMap.first[widget.value.datasetAttr]
                                    as Map<String, dynamic>)
                                .keys
                                .toSet()
                                .contains(widget.value.datasetSubMapData)
                            ? widget.value.datasetSubMapData
                            : null,
                        items: (dataset.getMap.first[widget.value.datasetAttr]
                                as Map<String, dynamic>)
                            .keys
                            .toSet()
                            .toList(),
                        onChange: (final newValue) {
                          setState(() {
                            datasetSubMapData = newValue!;
                          });
                          final old = widget.value;
                          widget.value.datasetSubMapData = newValue;
                          widget.value.datasetSubListData = '';
                          widget.callBack(widget.value, old);
                        },
                      ),
                    ),

                if (widget.valueType == VariableType.string ||
                    widget.valueType == VariableType.dynamic)
                  if (widget.value.type == FTextTypeEnum.dataset &&
                      widget.value.datasetName != null &&
                      widget.value.datasetAttr != null &&
                      dataset.isSubList(widget.value.datasetAttr ?? ''))
                    Padding(
                      padding: EI.smT,
                      child: CDropdown(
                        value: ((dataset.getMap.first[widget.value.datasetAttr]
                                        as List)
                                    .map(
                                      (final dynamic e) =>
                                          <String, dynamic>{...e},
                                    )
                                    .toList())
                                .first
                                .keys
                                .toSet()
                                .contains(widget.value.datasetSubListData)
                            ? widget.value.datasetSubListData
                            : null,
                        items: ((dataset.getMap.first[widget.value.datasetAttr]
                                    as List)
                                .map(
                                  (final dynamic e) => <String, dynamic>{...e},
                                )
                                .toList())
                            .first
                            .keys
                            .toSet()
                            .toList(),
                        onChange: (final newValue) {
                          setState(() {
                            datasetSubListData = newValue!;
                          });
                          final old = widget.value;
                          widget.value.datasetSubListData = newValue;
                          widget.value.datasetSubMapData = '';

                          widget.callBack(widget.value, old);
                        },
                      ),
                    ),
                /////////
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
                            const TParagraph('Combination'),
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
                                    widget.value.combination!
                                        .add(FTextTypeInput());
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
                            valueType: VariableType.dynamic,
                            value: element,
                            title: '',
                            isSubControl: true,
                            withConvertTo: true,
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
                else if (widget.withConvertTo)
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
        ),
      ),
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
                                title: TParagraph(
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
