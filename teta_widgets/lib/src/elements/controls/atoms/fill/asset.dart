// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class AssetFillControl extends StatefulWidget {
  const AssetFillControl({
    required this.node,
    required this.fill,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FFill fill;
  final Function(FFill, bool, FFill) callBack;

  @override
  AssetFillControlState createState() => AssetFillControlState();
}

class AssetFillControlState extends State<AssetFillControl> {
  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusProjectBloc, FocusProjectState>(
      builder: (final context, final prjState) => prjState is ProjectLoaded
          ? BlocBuilder<FocusBloc, List<CNode>>(
              builder: (final context, final state) {
                //updateState(state);

                return BlocBuilder<SupabaseCubit, SupabaseClient?>(
                  builder: (final context, final client) {
                    if (client == null) return const SizedBox();
                    final _future = getList(client, prjState.prj);
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
                            if (list.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 72),
                                child: TParagraph(
                                  'Your bucket is empty. Upload your first file.',
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            Row(
                              children: [
                                Expanded(
                                  child: CDropdownImageAssets(
                                    value: widget.fill.file,
                                    items: list,
                                    onChange: (final value) {
                                      PaletteModel? model;
                                      BlocProvider.of<ColorStylesCubit>(context)
                                          .state
                                          .forEach((final element) {
                                        if (element.name == value.name) {
                                          model = element;
                                        }
                                      });
                                      final old = FFill()
                                          .fromJson(widget.fill.toJson());
                                      widget.fill.paletteStyle = model!.id;
                                      widget.callBack(
                                        widget.fill,
                                        false,
                                        old,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
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
