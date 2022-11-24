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
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class ApiCallsRequestControl extends StatefulWidget {
  const ApiCallsRequestControl({
    required this.node,
    required this.requestName,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final String? requestName;
  final Function(String, String?, Map<String, dynamic>) callBack;

  @override
  ApiCallsRequestControlState createState() => ApiCallsRequestControlState();
}

class ApiCallsRequestControlState extends State<ApiCallsRequestControl> {
  int? nodeId;
  bool? isUpdated;
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
    nodeId = widget.node.nid;
  }

  void getRequest() async {
    allCollections = await TetaCMS.instance.client.getCollections();
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
    _requestList = await TetaCMS.instance.client.getCollection(
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
    );

    for (final e in _requestList) {
      requestNames.add((e as Map<String, dynamic>)['_name'].toString());
    }

    setState(() {});
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: BlocBuilder<FocusBloc, List<CNode>>(
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
                    THeadline3(
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
                            (widget.node.body.attributes[DBKeys.requestName]
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
                      if (widget.node.body.attributes[DBKeys.requestName] !=
                              null &&
                          widget.node.body.attributes[DBKeys.requestName]
                              is FTextTypeInput) {
                        (widget.node.body.attributes[DBKeys.requestName]
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
      ),
    );
  }
}
