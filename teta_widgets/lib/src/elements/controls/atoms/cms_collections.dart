// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class CMSCollectionControl extends StatefulWidget {
  const CMSCollectionControl({
    required this.collectionId,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String? collectionId;
  final Function(String, String?) callBack;

  @override
  CMSCollectionControlState createState() => CMSCollectionControlState();
}

class CMSCollectionControlState extends State<CMSCollectionControl> {
  String? dropdown;
  late Future<List<CollectionObject>> _future;

  @override
  void initState() {
    super.initState();
    _future = TetaCMS.instance.client.getCollections();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Row(
                children: const [
                  TParagraph(
                    'Collection',
                  ),
                ],
              ),
            ),
            FutureBuilder<List<CollectionObject>>(
              future: _future,
              builder: (final context, final snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                dropdown = snapshot.data!
                    .firstWhereOrNull(
                      (final element) =>
                          element.id ==
                          (widget.collectionId ??
                              (state.first.body.attributes[DBKeys.cmsCollection]
                                      as FTextTypeInput?)
                                  ?.value),
                    )
                    ?.name;
                final list = snapshot.data!
                    .where(
                      (final element) =>
                          element.schema == CollectionSchema.public,
                    )
                    .toList();
                return CDropdown(
                  value: dropdown,
                  items: list.map((final e) => e.name).toList(),
                  onChange: (final newValue) {
                    if (newValue != null) {
                      setState(() {
                        dropdown = newValue;
                      });

                      final old = widget.collectionId;
                      final nw = list
                          .firstWhereOrNull(
                            (final element) => element.name == dropdown,
                          )
                          ?.id;
                      if (state.first.body.attributes[DBKeys.cmsCollection] !=
                              null &&
                          state.first.body.attributes[DBKeys.cmsCollection]
                              is FTextTypeInput) {
                        (state.first.body.attributes[DBKeys.cmsCollection]
                                as FTextTypeInput)
                            .value = nw;
                      }
                      if (nw != null) {
                        widget.callBack(nw, old);
                      }
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
