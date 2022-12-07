// ignore_for_file: avoid_dynamic_calls

// Flutter imports:
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_cms/teta_cms.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WApiCallsFetch extends StatefulWidget {
  const WApiCallsFetch(
    final Key? key, {
    required this.node,
    required this.requestName,
    required this.apiCallsResponseName,
    required this.apiCallsDynamicValue,
    this.apiCallsSelectedRequest,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;
  final String requestName;
  final FTextTypeInput apiCallsResponseName;
  final List<MapElement>? apiCallsDynamicValue;
  final Map<String, dynamic>? apiCallsSelectedRequest;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WApiCallsFetch> createState() => _WApiCallsFetchState();
}

class _WApiCallsFetchState extends State<WApiCallsFetch> {
  bool isInitialized = false;
  List<dynamic> list = <dynamic>[];

  Future<void> getDataFromURL() async {
    final apiCallsSelectedRequest = widget.apiCallsSelectedRequest;
    final apiCallsDynamicValues = <String, dynamic>{};
    final apiCallsDynamicValue = widget.apiCallsDynamicValue;
    for (final e in apiCallsDynamicValue ?? <MapElement>[]) {
      var value = e.value.toCode(
        0,
        resultType: ResultTypeEnum.string,
      );

      if (value.contains('this.datasets')) {
        value = '\${$value}';
      } else {
        value = value.replaceAll("'", '').replaceAll(' ', '');
      }
      apiCallsDynamicValues[e.key] = value;
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
        var mapHeaders2 = <String, dynamic>{};
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
        var mapBody2 = <String, dynamic>{};
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
        var mapParameters2 = <String, dynamic>{};

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
      mapParameters.forEach((key, dynamic value) {
        if (firstLoop) {
          newURL = '$newURL?$key=${value.toString()}';
          firstLoop = false;
        } else {
          newURL = '$newURL&$key=${value.toString()}';
        }
      });

      final uri = Uri.parse(newURL);

      var headersNew = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers':
            'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
        'Access-Control-Allow-Methods': 'POST, OPTIONS'
      };
      mapHeaders.forEach((key, dynamic value) {
        headersNew[key] = value.toString();
      });

      final response = await http.get(Uri.parse(newURL), headers: headersNew);

      final json = response.body;

      dynamic resp = jsonDecode(json);
      if (resp is List) {
        final data = resp;
        if (mounted) {
          setState(() {
            list = data;
            isInitialized = true;
          });
        }
      } else {
        final data = <dynamic>[];
        data.add(resp);
        if (mounted) {
          setState(() {
            list = data;
            isInitialized = true;
          });
        }
      }
    } catch (e) {
      print("error:" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromURL();
  }

  @override
  Widget build(BuildContext context) {
    final datasets = _addFetchDataToDataset(list);

    if (list.isEmpty) {
      if (widget.children.length > 1) {
        return RepaintBoundary(
          child: widget.children.last.toWidget(
            params: widget.params,
            states: widget.states,
            dataset: datasets,
            forPlay: widget.forPlay,
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
      node: widget.node,
      forPlay: widget.forPlay,
      child: widget.children.isEmpty
          ? const THeadline3('Api Calls Fetch requires at least one child')
          : RepaintBoundary(
              child: widget.children.first.toWidget(
                params: widget.params,
                states: widget.states,
                dataset: datasets,
                forPlay: widget.forPlay,
              ),
            ),
    );
  }

  List<DatasetObject> _addFetchDataToDataset(final List<dynamic>? list) {
    final apiCallsResponseNameNew = widget.apiCallsResponseName.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
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

    final datasets = addDataset(context, widget.dataset, _map);

    return widget.dataset.isEmpty ? datasets : widget.dataset;
  }
}
