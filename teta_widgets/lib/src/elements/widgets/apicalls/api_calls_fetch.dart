// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:async';
import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class WApiCallsFetch extends StatefulWidget {
  const WApiCallsFetch(
    final Key? key, {
    required this.state,
    required this.children,
    required this.requestName,
    required this.apiCallsResponseName,
    required this.apiCallsDynamicValue,
    this.apiCallsSelectedRequest,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final String requestName;
  final FTextTypeInput apiCallsResponseName;
  final List<MapElement>? apiCallsDynamicValue;
  final Map<String, dynamic>? apiCallsSelectedRequest;

  @override
  State<WApiCallsFetch> createState() => _WApiCallsFetchState();
}

class _WApiCallsFetchState extends State<WApiCallsFetch> with AfterLayoutMixin {
  bool isInitialized = false;
  List<dynamic> list = <dynamic>[];

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    getDataFromURL();
  }

  Future<void> getDataFromURL() async {
    final apiCallsSelectedRequest = widget.apiCallsSelectedRequest;
    final apiCallsDynamicValues = <String, dynamic>{};
    final apiCallsDynamicValue = widget.apiCallsDynamicValue;
    for (final e in apiCallsDynamicValue ?? <MapElement>[]) {
      if (e.key.isEmpty) {
        break;
      }
      var value = e.value.toCode(
        0,
        resultType: ResultTypeEnum.string,
      );

      if (value.contains('this.datasets')) {
        value = '\${$value}';
      } else {
        value = value.replaceAll("'", '').replaceAll(' ', '');
      }
      if (value != null && value != '' && value != '0') {
        apiCallsDynamicValues[e.key] = value;
      }
    }
    //
    var mapParameters = <String, dynamic>{};
    var mapHeaders = <String, dynamic>{};
    var mapBody = <String, dynamic>{};

    var url = '';
    apiCallsSelectedRequest!.forEach((final key, final dynamic value) {
      if (key == 'requestURL') {
        url = value as String;
        var changeValue = url;
        apiCallsDynamicValues.forEach(
          (final keyDynamic, final dynamic valueDynamic) => {
            if (changeValue.contains(keyDynamic))
              {
                changeValue =
                    changeValue.replaceAll(keyDynamic, '$valueDynamic'),
              },
            url = changeValue
          },
        );
      }
      if (key == 'headers') {
        mapHeaders = value as Map<String, dynamic>;
        final mapHeaders2 = <String, dynamic>{};
        mapHeaders.forEach(
          (final key, final dynamic value) {
            var changeKey = key;
            var changeValue = value.toString();
            apiCallsDynamicValues.forEach(
              (final keyDynamic, final dynamic valueDynamic) {
                // check if dynamicValue  both key and value
                if (changeKey.contains(keyDynamic) &&
                    changeValue.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                  changeValue =
                      value.toString().replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in key
                else if (changeKey.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in value
                else if (changeValue.contains(keyDynamic)) {
                  changeValue =
                      changeValue.replaceAll(keyDynamic, '$valueDynamic');
                }
              },
            );
            //Update new map
            mapHeaders2[changeKey] = changeValue;
          },
        );
        mapHeaders = mapHeaders2;
      }
      if (key == 'body') {
        mapBody = value as Map<String, dynamic>;
        final mapBody2 = <String, dynamic>{};
        mapBody.forEach(
          (final key, final dynamic value) {
            var changeKey = key;
            var changeValue = value.toString();
            apiCallsDynamicValues.forEach(
              (final keyDynamic, final dynamic valueDynamic) {
                // check if dynamicValue  both key and value
                if (changeKey.contains(keyDynamic) &&
                    changeValue.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                  changeValue =
                      value.toString().replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in key
                else if (changeKey.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in value
                else if (changeValue.contains(keyDynamic)) {
                  changeValue =
                      changeValue.replaceAll(keyDynamic, '$valueDynamic');
                }
              },
            );
            //Update new map
            mapBody2[changeKey] = changeValue;
          },
        );
        mapBody = mapBody2;
      }
      if (key == 'params') {
        mapParameters = value as Map<String, dynamic>;
        final mapParameters2 = <String, dynamic>{};

        mapParameters.forEach(
          (final key, final dynamic value) {
            var changeKey = key;
            var changeValue = value.toString();
            apiCallsDynamicValues.forEach(
              (final keyDynamic, final dynamic valueDynamic) {
                // check if dynamicValue  both key and value
                if (changeKey.contains(keyDynamic) &&
                    changeValue.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                  changeValue =
                      value.toString().replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in key
                else if (changeKey.contains(keyDynamic)) {
                  changeKey = changeKey.replaceAll(keyDynamic, '$valueDynamic');
                }
                //check if dynamicValue in value
                else if (changeValue.contains(keyDynamic)) {
                  changeValue =
                      changeValue.replaceAll(keyDynamic, '$valueDynamic');
                }
              },
            );
            //Update new map
            mapParameters2[changeKey] = changeValue;
          },
        );
        mapParameters = mapParameters2;
      }
    });
    try {
      var newURL = url;
      var firstLoop = true;
      mapParameters.forEach((final key, final dynamic value) {
        if (firstLoop) {
          newURL = '$newURL?$key=${value.toString()}';
          firstLoop = false;
        } else {
          newURL = '$newURL&$key=${value.toString()}';
        }
      });

      final uri = Uri.parse(newURL);

      final headersNew = <String, String>{};
      mapHeaders.forEach((final key, final dynamic value) {
        headersNew[key] = value.toString();
      });

      final response = await http.get(Uri.parse(newURL), headers: headersNew);

      final json = response.body;
      final statusCode = <String, dynamic>{'statusCode': response.statusCode};
      final dynamic resp = jsonDecode(json);
      if (resp is List) {
        final data = (resp)
            .map((final dynamic e) => <String, dynamic>{...e, ...statusCode})
            .toList();
        if (mounted) {
          setState(() {
            list = data;
            isInitialized = true;
          });
        }
      } else {
        final data = <dynamic>[
          <String, dynamic>{...resp, ...statusCode}
        ];
        if (mounted) {
          setState(() {
            list = data;
            isInitialized = true;
          });
        }
      }
    } catch (e) {
      print('error:$e');
    }
  }

  @override
  Widget build(final BuildContext context) {
    final datasets = _addFetchDataToDataset(list);

    if (list.isEmpty) {
      if (widget.children.length > 1) {
        return RepaintBoundary(
          child: widget.children.last.toWidget(
            state: widget.state.copyWith(
              dataset: datasets,
            ),
          ),
        );
      } else {
        return const THeadline3(
          'Api Calls Fetch returned an empty list. Add children to customize this message,',
          isCentered: true,
        );
      }
    }
    return NodeSelectionBuilder(
      state: widget.state,
      child: widget.children.isEmpty
          ? const THeadline3('Api Calls Fetch requires at least one child')
          : RepaintBoundary(
              child: widget.children.first.toWidget(
                state: widget.state.copyWith(
                  dataset: datasets,
                ),
              ),
            ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final List<dynamic>? list) {
    final apiCallsResponseNameNew = widget.apiCallsResponseName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    String datasetName;
    if (apiCallsResponseNameNew.isEmpty) {
      datasetName = 'Api Calls Fetch';
    } else {
      datasetName = apiCallsResponseNameNew;
    }

    final _map = DatasetObject(
      name: datasetName,
      map: (list ?? const <dynamic>[])
          .map((final dynamic e) => e as Map<String, dynamic>)
          .toList(),
    );

    final datasets = addDataset(context, _map);

    return widget.state.dataset.isEmpty ? datasets : widget.state.dataset;
  }
}
