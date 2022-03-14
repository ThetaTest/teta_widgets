// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/src/blocs/focus/index.dart';
import 'package:teta_core/src/blocs/focus_project/index.dart';
import 'package:teta_core/src/blocs/panels/index.dart';
import 'package:teta_core/src/cubits/supabase.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown_for_type.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown_image_assets.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/src/models/asset_file.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/project.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class SrcImageControl extends StatefulWidget {
  const SrcImageControl({
    required this.node,
    required this.page,
    required this.title,
    required this.image,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final PageObject page;
  final String title;
  final FTextTypeInput image;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  SrcImageControlState createState() => SrcImageControlState();
}

class SrcImageControlState extends State<SrcImageControl> {
  int? nodeId;
  bool? isUpdated;
  String? text;
  TextEditingController controller = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;
  List<String> list = [];

  @override
  void initState() {
    try {
      nodeId = widget.node.nid;
      text = widget.image.value ?? '';
      controller.text = widget.image.value!;
      typeOfInput = widget.image.type!;
      databaseName = widget.image.datasetName!;
      databaseAttribute = widget.image.datasetAttr!;
    } catch (_) {}
    try {
      list = (widget.page.datasets.indexWhere(
                (final element) => element.getName == widget.image.datasetName,
              ) !=
              -1)
          ? widget.page.datasets
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
    return BlocBuilder<FocusProjectBloc, FocusProjectState>(
      builder: (final context, final prjState) => prjState is ProjectLoaded
          ? BlocListener<FocusBloc, List<CNode>>(
              listener: (final context, final state) {
                if (state.isNotEmpty) {
                  if (state.first.nid != nodeId) {
                    setState(() {
                      isUpdated = true;
                      controller.text = widget.image.value ?? '';
                    });
                    nodeId = state.first.nid;
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        widget.title,
                        typography: const Headline3(),
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
                        items: const [
                          'text',
                          'param',
                          'state',
                          'dataset',
                          'asset'
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
                      value: widget.page.params
                              .map((final e) => e.name)
                              .toSet()
                              .toList()
                              .contains(widget.image.paramName)
                          ? widget.image.paramName
                          : null,
                      items: widget.page.params
                          .map((final e) => e.name)
                          .toSet()
                          .toList(),
                      onChange: (final newValue) {
                        final old = widget.image;
                        widget.image.paramName = newValue;
                        widget.callBack(widget.image, old);
                      },
                    ),
                  if (widget.image.type == FTextTypeEnum.state)
                    CDropdown(
                      value: widget.page.states
                              .map((final e) => e.name)
                              .toSet()
                              .toList()
                              .contains(widget.image.stateName)
                          ? widget.image.stateName
                          : null,
                      items: widget.page.states
                          .map((final e) => e.name)
                          .toSet()
                          .toList(),
                      onChange: (final newValue) {
                        final old = widget.image;
                        widget.image.stateName = newValue;
                        widget.callBack(widget.image, old);
                      },
                    ),
                  if (widget.image.type == FTextTypeEnum.dataset)
                    CDropdown(
                      value: widget.page.datasets
                              .map((final e) => e.getName)
                              .where((final element) => element != 'null')
                              .toSet()
                              .contains(widget.image.datasetName)
                          ? widget.image.datasetName
                          : null,
                      items: widget.page.datasets
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
                    CDropdown(
                      value: widget.page.datasets.indexWhere(
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
                  if (widget.image.type == FTextTypeEnum.asset)
                    BlocBuilder<SupabaseCubit, SupabaseClient?>(
                      builder: (final context, final client) {
                        if (client == null) return const SizedBox();
                        return FutureBuilder(
                          future: getList(client, prjState.prj),
                          builder: (final context, final snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final list = snapshot.data as List<AssetFile>? ??
                                <AssetFile>[];
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
                                        BlocProvider.of<PanelsBloc>(context)
                                            .add(
                                          const ChangeIndex(
                                            type: PanelsEnum.assets,
                                          ),
                                        );
                                      },
                                      child: const MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: CText(
                                          'Your bucket is empty. Upload your first file >',
                                          typography: DetailLabel(),
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
            )
          : const SizedBox(),
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
