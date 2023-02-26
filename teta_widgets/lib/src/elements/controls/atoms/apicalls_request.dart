// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class ApiCallsRequestControl extends StatefulWidget {
  const ApiCallsRequestControl({
    required this.requestName,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final String? requestName;
  final Function(String, String?, Map<String, dynamic>) callBack;

  @override
  ApiCallsRequestControlState createState() => ApiCallsRequestControlState();
}

class ApiCallsRequestControlState extends State<ApiCallsRequestControl> {
  String? dropdown;
  List<String> items = <String>[];
  CollectionObject? collection;
  List<CollectionObject> allCollections = [];
  List<dynamic> _requestList = <dynamic>[];
  List<String> requestNames = [];
  String? collectionID;

  @override
  void initState() {
    getRequest();
    super.initState();
  }

  Future<void> getRequest() async {
    final res = await TetaCMS.I.db.getCollections();
    if (res.error != null) return;
    allCollections = res.data!;
    collectionID = allCollections
        .where(
          (final element) =>
              element.name == '_apiCallsRequests' &&
              element.schema == CollectionSchema.private &&
              element.role == CollectionRole.request,
        )
        .toList()
        .first
        .id;
    final resCollection = await TetaCMS.I.db
        .fromId(
          allCollections
              .where(
                (final element) =>
                    element.name == '_apiCallsRequests' &&
                    element.schema == CollectionSchema.private &&
                    element.role == CollectionRole.request,
              )
              .toList()
              .first
              .id,
        )
        .get();
    if (resCollection.error != null) return;
    _requestList = resCollection.data!;

    for (final e in _requestList) {
      requestNames.add((e as Map<String, dynamic>)['_name'].toString());
    }

    setState(() {});
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<int>>(
      builder: (final context, final state) {
        if (state.length != 1) return const SizedBox();
        final nodeId = state.first;
        final node = (context.read<PageCubit>().state as PageLoaded)
            .page
            .flatList
            .firstWhere((final element) => element.nid == nodeId);
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
                    'Request',
                  ),
                ],
              ),
            ),
            if (_requestList != <dynamic>[])
              CDropdown(
                value: requestNames.firstWhereOrNull(
                  (final element) =>
                      element ==
                      (widget.requestName ??
                          (node.body.attributes[DBKeys.requestName]
                                  as FTextTypeInput?)
                              ?.value),
                ),
                items: requestNames,
                onChange: (final newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdown = newValue;
                    });
                    var requestData = <String, dynamic>{};
                    for (final e in _requestList) {
                      if ((e as Map<String, dynamic>)['_name'].toString() ==
                          dropdown) {
                        requestData = e;
                      }
                    }
                    final old = widget.requestName;
                    final nw = requestNames.firstWhereOrNull(
                      (final element) => element == dropdown,
                    );
                    if (node.body.attributes[DBKeys.requestName] != null &&
                        node.body.attributes[DBKeys.requestName]
                            is FTextTypeInput) {
                      (node.body.attributes[DBKeys.requestName]
                              as FTextTypeInput)
                          .value = nw;
                    }
                    if (nw != null) {
                      widget.callBack(nw, old, requestData);
                    }
                  }
                },
              ),
          ],
        );
      },
    );
  }
}
