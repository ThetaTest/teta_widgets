// Flutter imports:
import 'dart:convert';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class FAApiCalls {
  static Future action(
    final BuildContext context,
    final String? apiCallsRequestName,
    final Map<String, dynamic>? apiCallsSelectedRequest,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final FTextTypeInput? apiCallsResponseName,
    final List<MapElement>? apiCallsDynamicValue,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final apiCallsDynamicValues = <String, dynamic>{};
    for (final e in apiCallsDynamicValue ?? <MapElement>[]) {
      apiCallsDynamicValues[e.key] =
          e.value.get(params, states, dataset, true, loop, context);
    }
    final customHttpRequestExpectedStatusCodeNew =
        customHttpRequestExpectedStatusCode?.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    final apiCallsResponseNameNew =
        apiCallsResponseName?.get(params, states, dataset, true, loop, context);
    var mapParameters = <String, dynamic>{};
    var mapHeaders = <String, dynamic>{};
    var mapBody = <String, dynamic>{};
    var requestType = '';
    var url = '';
    apiCallsSelectedRequest!.forEach((final key, final dynamic value) {
      if (key == 'requestType') {
        requestType = value as String;
      }
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
    // ignore: omit_local_variable_types
    DatasetObject _map = DatasetObject(
      name: apiCallsResponseNameNew ?? 'Api Calls',
      map: [<String, dynamic>{}],
    );

    if (url != '' && customHttpRequestExpectedStatusCodeNew != null) {
      if (requestType == 'Get') {
        final response = await TetaCMS.instance.httpRequest.get(
          url,
          customHttpRequestExpectedStatusCodeNew,
          mapParameters,
          mapBody,
          mapHeaders,
        );
        if (response.data != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.data ?? const <dynamic>[])
                .map((final dynamic e) => <String, dynamic>{...e})
                .toList(),
          );
        }
        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.error!).map((final dynamic e) {
              return e as Map<String, dynamic>;
            }).toList(),
          );
        }

        addDataset(context, dataset, _map);
      }
      if (requestType == 'Post') {
        final response = await TetaCMS.instance.httpRequest.post(
          url,
          customHttpRequestExpectedStatusCodeNew,
          mapParameters,
          mapBody,
          mapHeaders,
        );
        if (response.data != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.data ?? const <dynamic>[])
                .map((final dynamic e) => <String, dynamic>{...e})
                .toList(),
          );
        }
        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.error!).map((final dynamic e) {
              return e as Map<String, dynamic>;
            }).toList(),
          );
        }

        addDataset(context, dataset, _map);
      }
      if (requestType == 'Delete') {
        final response = await TetaCMS.instance.httpRequest.delete(
          url,
          customHttpRequestExpectedStatusCodeNew,
          mapParameters,
          mapHeaders,
        );
        if (response.data != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.data ?? const <dynamic>[])
                .map((final dynamic e) => <String, dynamic>{...e})
                .toList(),
          );
        }
        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.error!).map((final dynamic e) {
              return e as Map<String, dynamic>;
            }).toList(),
          );
        }
        addDataset(context, dataset, _map);
      }
      if (requestType == 'Update') {
        final response = await TetaCMS.instance.httpRequest.update(
          url,
          customHttpRequestExpectedStatusCodeNew,
          mapParameters,
          mapBody,
          mapHeaders,
        );
        if (response.data != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.data ?? const <dynamic>[])
                .map(
                  (final dynamic e) => <String, dynamic>{...e},
                )
                .toList(),
          );
        }

        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew,
            map: (response.error!)
                .map(
                  (final dynamic e) => <String, dynamic>{
                    ...e,
                  },
                )
                .toList(),
          );
        }
        addDataset(context, dataset, _map);
      }
    }
  }

  static String toCode(
    final String? apiCallsRequestName,
    final Map<String, dynamic>? apiCallsSelectedRequest,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final FTextTypeInput? apiCallsResponseName,
    final List<MapElement>? apiCallsDynamicValue,
    final int? loop,
  ) {
    final apiCallsDynamicValues = <String, dynamic>{};
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
    var mapParameters = <String, dynamic>{};
    var mapHeaders = <String, dynamic>{};
    var mapBody = <String, dynamic>{};
    var requestType = '';
    var url = '';
    apiCallsSelectedRequest!.forEach((final key, final dynamic value) {
      if (key == 'requestType') {
        requestType = value as String;
      }
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
    final mapParametersString = StringBuffer()..write('{');
    for (final key in mapParameters.keys) {
      mapParametersString.write("'$key': '${mapParameters[key]}',");
    }
    mapParametersString.write('}');

    final mapHeadersString = StringBuffer()..write('{');
    for (final key in mapHeaders.keys) {
      mapHeadersString.write("'$key': '${mapHeaders[key]}',");
    }
    mapHeadersString.write('}');

    final mapBodyString = StringBuffer()..write('{');
    for (final key in mapBody.keys) {
      mapBodyString.write("'$key': '${mapBody[key]}',");
    }
    mapBodyString.write('}');
    final customHttpRequestExpectedStatusCodeNew =
        customHttpRequestExpectedStatusCode
            ?.toCode(
              loop,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '')
            .replaceAll(' ', '');
    final apiCallsResponseNameNew = apiCallsResponseName
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    var requestTypeToString = '';

    var toCode = '''''';
    if (requestType == 'Delete') {
      requestTypeToString = 'delete';
      toCode =
          // ignore: leading_newlines_in_multiline_strings
          '''final response = await TetaCMS.instance.httpRequest.${requestTypeToString}('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,<String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];''';
    }
    if (requestType == 'Post') {
      requestTypeToString = 'post';
      toCode =
          // ignore: leading_newlines_in_multiline_strings
          '''final response = await TetaCMS.instance.httpRequest.$requestTypeToString('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,  <String, dynamic>$mapBodyString, <String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];''';
    }
    if (requestType == 'Update') {
      requestTypeToString = 'update';
      toCode =
          // ignore: leading_newlines_in_multiline_strings
          '''final response = await TetaCMS.instance.httpRequest.${requestTypeToString}('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,  <String, dynamic>$mapBodyString, <String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];''';
    }
    if (requestType == 'Get') {
      requestTypeToString = 'get';
      toCode =
          // ignore: leading_newlines_in_multiline_strings
          '''final response = await TetaCMS.instance.httpRequest.${requestTypeToString}('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,  <String, dynamic>$mapBodyString, <String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];''';
    }
    return toCode;
  }
}