// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class SrcImageControl extends StatefulWidget {
  const SrcImageControl({
    required this.title,
    required this.image,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String title;
  final FTextTypeInput image;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  SrcImageControlState createState() => SrcImageControlState();
}

class SrcImageControlState extends State<SrcImageControl> {
  String? text;
  TextEditingController controller = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;
  List<String> list = [];

  @override
  void initState() {
    try {
      text = widget.image.value ?? '';
      controller.text = controller.text = widget.image.getValue(
        context,
        forPlay: false,
      );
      typeOfInput = widget.image.type!;
      databaseName = widget.image.datasetName!;
      databaseAttribute = widget.image.datasetAttr!;
    } catch (_) {}
    try {
      final pageState = context.watch<PageCubit>().state as PageLoaded;
      list = (pageState.datasets.indexWhere(
                (final element) => element.getName == widget.image.datasetName,
              ) !=
              -1)
          ? pageState.datasets
              .firstWhere(
                (final element) => element.getName == widget.image.datasetName,
                orElse: () {
                  return DatasetObject.empty();
                },
              )
              .getMap
              .first
              .keys
              .toSet()
              .toList()
          : <String>[];
    } catch (e) {
      list = [];
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final pageState = context.watch<PageCubit>().state as PageLoaded;
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          controller.text = widget.image.value ?? '';
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TParagraph(
                widget.title,
              ),
              CDropdownForType(
                value: widget.image.type == FTextTypeEnum.asset
                    ? 'asset'
                    : widget.image.type == FTextTypeEnum.dataset
                        ? 'dataset'
                        : widget.image.type == FTextTypeEnum.state
                            ? 'state'
                            : widget.image.type == FTextTypeEnum.param
                                ? 'param'
                                : 'text',
                items: const ['text', 'param', 'state', 'dataset', 'asset'],
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
                  if (value == 'asset') {
                    typeOfInput = FTextTypeEnum.asset;
                  }
                  final old = widget.image;
                  final newValue = widget.image..type = typeOfInput;
                  widget.callBack(newValue, old);
                },
              ),
            ],
          ),
          if (widget.image.type == FTextTypeEnum.text)
            CTextField(
              text: widget.image.value,
              controller: controller,
              callBack: (final value) {
                value.replaceAll(r'\', r'\\');
                final old = widget.image;
                widget.image.value = value;
                widget.callBack(widget.image, old);
              },
              onSubmitted: (final value) {
                value.replaceAll(r'\', r'\\');
                final old = widget.image;
                widget.image.value = value;
                widget.callBack(widget.image, old);
              },
            ),
          if (widget.image.type == FTextTypeEnum.param)
            CDropdown(
              value: pageState.params
                      .map((final e) => e.name)
                      .toSet()
                      .toList()
                      .contains(widget.image.paramName)
                  ? widget.image.paramName
                  : null,
              items: pageState.params.map((final e) => e.name).toSet().toList(),
              onChange: (final newValue) {
                final old = widget.image;
                widget.image.paramName = newValue;
                widget.callBack(widget.image, old);
              },
            ),
          if (widget.image.type == FTextTypeEnum.state)
            CDropdown(
              value: pageState.states
                      .map((final e) => e.name)
                      .toSet()
                      .toList()
                      .contains(widget.image.stateName)
                  ? widget.image.stateName
                  : null,
              items: pageState.states.map((final e) => e.name).toSet().toList(),
              onChange: (final newValue) {
                final old = widget.image;
                widget.image.stateName = newValue;
                widget.callBack(widget.image, old);
              },
            ),
          if (widget.image.type == FTextTypeEnum.dataset)
            CDropdown(
              value: pageState.datasets
                      .map((final e) => e.getName)
                      .where((final element) => element != 'null')
                      .toSet()
                      .contains(widget.image.datasetName)
                  ? widget.image.datasetName
                  : null,
              items: pageState.datasets
                  .map((final e) => e.getName)
                  .where((final element) => element != 'null')
                  .toSet()
                  .toList(),
              onChange: (final newValue) {
                setState(() {
                  databaseName = newValue!;
                });
                final old = widget.image;
                widget.image.datasetName = newValue;
                widget.callBack(widget.image, old);
              },
            ),
          if (widget.image.type == FTextTypeEnum.dataset &&
              widget.image.datasetName != null)
            Padding(
              padding: EI.smT,
              child: CDropdown(
                value: pageState.datasets.indexWhere(
                          (final element) =>
                              element.getName == widget.image.datasetName,
                        ) !=
                        -1
                    ? widget.image.datasetAttr
                    : null,
                items: list,
                onChange: (final newValue) {
                  setState(() {
                    databaseAttribute = newValue!;
                  });
                  final old = widget.image;
                  widget.image.datasetAttr = newValue;
                  widget.callBack(widget.image, old);
                },
              ),
            ),
          if (widget.image.type == FTextTypeEnum.asset)
            BlocBuilder<SupabaseCubit, SupabaseClient?>(
              builder: (final context, final client) {
                if (client == null) return const SizedBox();
                final _future = getList(
                  client,
                  BlocProvider.of<FocusProjectCubit>(context).state!,
                );
                return FutureBuilder<List<AssetFile>>(
                  future: _future,
                  builder: (final context, final snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final list = snapshot.data ?? <AssetFile>[];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CDropdownImageAssets(
                                value: widget.image.file,
                                items: list,
                                onChange: (final value) {
                                  final old = widget.image;
                                  widget.image.file = value;
                                  widget.callBack(widget.image, old);
                                },
                              ),
                            ),
                          ],
                        ),
                        if (list.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<PanelsCubit>(context)
                                    .changePanel(
                                  PanelsEnum.assets,
                                );
                              },
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: TDetailLabel(
                                  'Your bucket is empty. Upload your first file >',
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  Future<List<AssetFile>> getList(
    final SupabaseClient client,
    final ProjectObject prj,
  ) async {
    final files =
        await client.storage.from('public').list(path: '${prj.name}/assets');
    if (files.error != null) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(files.error?.message);
      }
      return <AssetFile>[];
    }
    final list = <AssetFile>[];
    for (final file in files.data ?? const <FileObject>[]) {
      final response = client.storage
          .from('public')
          .getPublicUrl('${prj.name}/assets/${file.name}');
      if (!response.hasError) {
        list.add(
          AssetFile(
            name: file.name,
            url: response.data ?? '',
          ),
        );
      }
    }
    return list;
  }
}
