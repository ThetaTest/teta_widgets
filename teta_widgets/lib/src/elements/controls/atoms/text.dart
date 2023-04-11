import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:dart_airtable/dart_airtable.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/src/design_system/textfield/multi_line_textfield.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../teta_widgets.dart';

class TextControl extends StatefulWidget {
  const TextControl({
    required this.valueType,
    required this.value,
    required this.title,
    required this.callBack,
    this.ignoreDeviceTypeValue = false,
    this.withConvertTo = false,
    this.isSubControl = false,
    this.remove,
    final Key? key,
  }) : super(key: key);

  final VariableType? valueType;
  final FTextTypeInput value;
  final String title;

  /// Updated each value: value,valueTable, valueDesktop
  final bool ignoreDeviceTypeValue;
  final bool isSubControl;
  final bool withConvertTo;
  final Function(FTextTypeInput, FTextTypeInput) callBack;
  final Function()? remove;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<TextControl> with AfterLayoutMixin {
  final controller = TextEditingController();
  final jsonMapPathController = TextEditingController();
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
    try {
      setState(() {
        controller.text = widget.value.getValue(
          context,
          forPlay: false,
        );
        jsonMapPathController.text = widget.value.jsonMapPath ?? '';
        typeOfInput = widget.value.type!;
        databaseName = widget.value.datasetName ?? '';
        final datasets =
            (context.read<PageCubit>().state as PageLoaded).datasets;
        final index = datasets.indexWhere(
          (final element) => element.getName == widget.value.datasetName,
        );
        dataset = index != -1 ? datasets[index] : DatasetObject.empty();
        Logger.printMessage(
          'Datasets: $datasets, name: ${widget.value.datasetName}, index: $index',
        );
        databaseAttribute = widget.value.datasetAttr ?? '';
        datasetSubListData = widget.value.datasetSubListData ?? '';
        datasetSubMapData = widget.value.datasetSubMapData ?? '';
        datasetLength = widget.value.datasetLength!;
      });
    } catch (e) {
      Logger.printError('Error in afterFirstLayout: $e');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    jsonMapPathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceModeCubit, DeviceState>(
      listener: (context, device) {
        if (controller.text != widget.value.getValue(context, forPlay: false)) {
          controller.text = widget.value.getValue(context, forPlay: false);
        }
      },
      child: BlocBuilder<DeviceModeCubit, DeviceState>(
        builder: (context, device) => BlocBuilder<FocusBloc, List<int>>(
          builder: (context, focusState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        if (widget.value.type == FTextTypeEnum.text &&
                            widget.ignoreDeviceTypeValue == false)
                          const DeviceIndicatorForControls(),
                        if (widget.value.type == FTextTypeEnum.text &&
                            widget.ignoreDeviceTypeValue == false)
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
                  ],
                ),
                const Gap(Grid.small),
                Row(
                  children: [
                    Expanded(
                      child: CDropdownCustom(
                        expanded: true,
                        background: Colors.transparent,
                        value: widget.value.type == FTextTypeEnum.dataset
                            ? 'dataset'
                            : widget.value.type == FTextTypeEnum.state
                                ? 'state'
                                : widget.value.type == FTextTypeEnum.param
                                    ? 'param'
                                    : widget.value.type ==
                                            FTextTypeEnum.combined
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
                    ),
                  ],
                ),
                const Gap(Grid.small),
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
                            ignoreDeviceTypeValue: widget.ignoreDeviceTypeValue,
                          );
                          EasyDebounce.debounce(
                            'Editing text ${focusState.first}',
                            const Duration(milliseconds: 500),
                            () => widget.callBack(widget.value, old),
                          );
                          setState(() => isChanged = false);
                        },
                        onSubmitted: (final value) {
                          value.replaceAll(r'\', r'\\');
                          final old = widget.value;
                          widget.value.updateValue(
                            value,
                            context,
                            ignoreDeviceTypeValue: widget.ignoreDeviceTypeValue,
                          );
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
                                sl
                                    .get<PageCubit>()
                                    .addParam(type: widget.valueType);
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
                          CDropdownCustom<String>(
                            value: state.page.defaultParams
                                    .map((final e) => e.name)
                                    .contains(widget.value.paramName)
                                ? widget.value.paramName
                                : null,
                            items: variables
                                .map(
                                  (final e) => DropdownCustomMenuItem(
                                    value: e.name,
                                    child: TParagraph(e.name),
                                  ),
                                )
                                .toList(),
                            onChange: (final newValue) {
                              final old = widget.value;
                              widget.value.paramName = newValue;
                              widget.callBack(widget.value, old);
                            },
                            expanded: true,
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
                                sl
                                    .get<PageCubit>()
                                    .addParam(type: widget.valueType);
                                context
                                    .read<PageCubit>()
                                    .addState(type: widget.valueType);
                              },
                            ),
                          ],
                        );
                      }
                      final selectedState =
                          state.page.defaultStates.firstWhereOrNull(
                        (e) => e.name == widget.value.stateName,
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TDetailLabel(
                            'It requires a ${widget.valueType!.name} variable',
                            color: Palette.txtPrimary.withOpacity(0.6),
                          ),
                          const Gap(Grid.small),
                          CDropdownCustom<String>(
                            value: selectedState?.name,
                            items: variables
                                .map(
                                  (final e) => DropdownCustomMenuItem(
                                    value: e.name,
                                    child: TParagraph(e.name),
                                  ),
                                )
                                .toList(),
                            onChange: (final newValue) {
                              final old = widget.value;
                              widget.value.stateName = newValue;
                              widget.callBack(widget.value, old);
                            },
                            expanded: true,
                          ),
                          const Gap(Grid.small),
                          if (selectedState?.type == VariableType.json)
                            descriptionControlWidget(
                              description:
                                  'Specify the path to the value. Path can '
                                  'contain indexes (e.g. `list.0.message`).\n'
                                  'Leave empty to use the whole JSON',
                              control: CMultiLinesTextField(
                                placeholder: 'Path to value '
                                    '(e.g. `messages.0.sender`)',
                                controller: jsonMapPathController,
                                callBack: (final value) {
                                  EasyDebounce.debounce(
                                    'Editing text ${focusState.first}',
                                    const Duration(milliseconds: 500),
                                    () => {
                                      widget.callBack(
                                        widget.value..jsonMapPath = value,
                                        widget.value,
                                      ),
                                    },
                                  );
                                },
                                onSubmitted: (final value) {
                                  value.replaceAll(r'\', r'\\');
                                  widget.callBack(
                                    widget.value..jsonMapPath = value,
                                    widget.value,
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                if (widget.value.type == FTextTypeEnum.languages)
                  BlocBuilder<ConfigCubit, ConfigState>(
                    builder: (final context, final state) {
                      if (state is! ConfigStateLoaded) return const SizedBox();
                      return CDropdownCustom<String>(
                        value: widget.value.keyTranslator,
                        items: state.config.appLanguage.terms.entries
                            .map(
                              (final e) => DropdownCustomMenuItem(
                                value: e.key,
                                child: TParagraph(e.key),
                              ),
                            )
                            .toList(),
                        onChange: (final value) {
                          final old = widget.value;
                          widget.value.keyTranslator = value;
                          widget.callBack(widget.value, old);
                          setState(() {});
                        },
                        expanded: true,
                      );
                    },
                  ),
                if (widget.value.type == FTextTypeEnum.dataset)
                  BlocBuilder<PageCubit, PageState>(
                    builder: (final context, final state) {
                      if (state is! PageLoaded) return const SizedBox();
                      return CDropdownCustom<String>(
                        value: state.datasets
                                .map((final e) => e.getName)
                                .where((final element) => element != 'null')
                                .contains(widget.value.datasetName)
                            ? widget.value.datasetName
                            : null,
                        items: state.datasets
                            .map((final e) => e.getName)
                            .where((final element) => element != 'null')
                            .map(
                              (final e) => DropdownCustomMenuItem(
                                value: e,
                                child: TParagraph(e),
                              ),
                            )
                            .toList(),
                        onChange: (final newValue) async {
                          final index = state.datasets.indexWhere(
                            (final element) => element.getName == newValue,
                          );
                          setState(() {
                            databaseName = newValue!;
                            dataset = index != -1
                                ? state.datasets[index]
                                : DatasetObject.empty();
                          });
                          final old = widget.value;
                          widget.value.datasetName = newValue;
                          widget.callBack(widget.value, old);
                        },
                        expanded: true,
                      );
                    },
                  ),
                if (widget.valueType == VariableType.string ||
                    widget.valueType == VariableType.dynamic)
                  if (widget.value.type == FTextTypeEnum.dataset &&
                      widget.value.datasetName != null)
                    Padding(
                      padding: EI.smT,
                      child: CDropdownCustom<String>(
                        expanded: true,
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
                            .map(
                              (final e) => DropdownCustomMenuItem(
                                value: e,
                                child: TParagraph(e),
                              ),
                            )
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
                      child: CDropdownCustom<String>(
                        expanded: true,
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
                            .map(
                              (final e) => DropdownCustomMenuItem(
                                value: e,
                                child: TParagraph(e),
                              ),
                            )
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
                      child: CDropdownCustom<String>(
                        expanded: true,
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
                            .map(
                              (final e) => DropdownCustomMenuItem(
                                value: e,
                                child: TParagraph(e),
                              ),
                            )
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
                        child: CDropdownCustom<String>(
                          expanded: true,
                          value: EnumToString.convertToString(
                            widget.value.resultType,
                            camelCase: true,
                          ),
                          items: EnumToString.toList(
                            ResultTypeEnum.values,
                            camelCase: true,
                          )
                              .map(
                                (e) => DropdownCustomMenuItem(
                                  value: e,
                                  child: TParagraph(e),
                                ),
                              )
                              .toList(),
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
                          child: CDropdownCustom<String>(
                            expanded: true,
                            value: widget.value.typeDateTimeFormat != null
                                ? EnumToString.convertToString(
                                    widget.value.typeDateTimeFormat,
                                    camelCase: true,
                                  )
                                : null,
                            items: EnumToString.toList(
                              TypeDateTimeFormat.values,
                              camelCase: true,
                            )
                                .map(
                                  (e) => DropdownCustomMenuItem(
                                    value: e,
                                    child: TParagraph(e),
                                  ),
                                )
                                .toList(),
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
