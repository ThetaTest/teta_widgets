import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/save_dataset.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../builder/save_dataset.dart';
import '../../../features/text_type_input.dart';
import 'params.dart';

class TAApiCallsExecute extends TetaAction {
  TAApiCallsExecute({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAApiCallsExecute.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAApiCallsExecuteParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TAApiCallsExecuteParams get params => super.params as TAApiCallsExecuteParams;

  @override
  TetaActionType get type => TetaActionType.apiCallsExecute;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    Logger.printWarning('selected Request: ${params.apiCallsSelectedRequest}');

    final apiCallsDynamicValues = <String, dynamic>{};
    for (final e in params.apiCallsDynamicValue ?? <MapElement>[]) {
      if (e.key.isEmpty) {
        break;
      }
      final value = e.value.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
      if (value != null && value != '' && value != '0') {
        apiCallsDynamicValues[e.key] = value;
      }
    }
    final customHttpRequestExpectedStatusCodeNew =
        params.customHttpRequestExpectedStatusCode?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    final apiCallsResponseNameNew = params.apiCallsResponseName?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    var mapParameters = <String, dynamic>{};
    var mapHeaders = <String, dynamic>{};
    var mapBody = <String, dynamic>{};
    var requestType = '';
    var url = '';
    var authorizationType = '';
    var mapBasicAuth = <String, dynamic>{};
    var mapBearerToken = <String, dynamic>{};
    params.apiCallsSelectedRequest!.forEach((final key, final dynamic value) {
      if (key == 'requestType') {
        requestType = value as String;
      }
      if (key == 'authorizationType') {
        authorizationType = value as String;
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

      ///

      if (key == 'basicAuth') {
        mapBasicAuth = value as Map<String, dynamic>;
        final mapBasicAuth2 = <String, dynamic>{};
        mapBasicAuth.forEach(
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
            mapBasicAuth2[changeKey] = changeValue;
          },
        );
        mapBasicAuth = mapBasicAuth2;
      }
      if (key == 'bearerToken') {
        mapBearerToken = value as Map<String, dynamic>;
        final mapBearerToken2 = <String, dynamic>{};
        mapBearerToken.forEach(
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
            mapBearerToken2[changeKey] = changeValue;
          },
        );
        mapBearerToken = mapBearerToken2;
      }

      ///
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
      //update headers with authorization
      if (authorizationType == 'Bearer token') {
        if (mapBearerToken.isNotEmpty) {
          final token = mapBearerToken['Token'] as String;
          if (token.isNotEmpty) {
            final map = {'authorization': 'Bearer $token'};
            mapHeaders.addAll(map);
          }
        }
      } else if (authorizationType == 'Basic auth') {
        if (mapBasicAuth.isNotEmpty) {
          final username = mapBasicAuth['Username'] as String;
          final password = mapBasicAuth['Password'] as String;
          if (username.isNotEmpty || password.isNotEmpty) {
            final auth =
                'Basic ${base64Encode(utf8.encode('$username:$password'))}';
            final map = {'authorization': auth};
            mapHeaders.addAll(map);
          }
        }
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
    // ignore: omit_local_variable_types
    DatasetObject _map = DatasetObject(
      name: apiCallsResponseNameNew ?? 'Api Calls',
      map: const [<String, dynamic>{}],
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
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.data ?? const <dynamic>[])
                .map((final dynamic e) => <String, dynamic>{...e})
                .toList(),
          );
        }
        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.error!).map((final dynamic e) {
              return e as Map<String, dynamic>;
            }).toList(),
          );
        }

        await saveDatasets(context, state.dataset, _map);
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
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.data ?? const <dynamic>[])
                .map((final dynamic e) => <String, dynamic>{...e})
                .toList(),
          );
        }
        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.error!).map((final dynamic e) {
              return e as Map<String, dynamic>;
            }).toList(),
          );
        }

        await saveDatasets(context, state.dataset, _map);
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
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.data ?? const <dynamic>[])
                .map((final dynamic e) => <String, dynamic>{...e})
                .toList(),
          );
        }
        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.error!).map((final dynamic e) {
              return e as Map<String, dynamic>;
            }).toList(),
          );
        }
        await saveDatasets(context, state.dataset, _map);
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
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.data ?? const <dynamic>[])
                .map(
                  (final dynamic e) => <String, dynamic>{...e},
                )
                .toList(),
          );
        }

        if (response.error != null) {
          _map = _map.copyWith(
            name: apiCallsResponseNameNew ?? 'Api Calls',
            map: (response.error!)
                .map(
                  (final dynamic e) => <String, dynamic>{
                    ...e,
                  },
                )
                .toList(),
          );
        }
        await saveDatasets(context, state.dataset, _map);
      }
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final apiCallsDynamicValues = <String, dynamic>{};
    for (final e in params.apiCallsDynamicValue ?? <MapElement>[]) {
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
    var mapParameters = <String, dynamic>{};
    var mapHeaders = <String, dynamic>{};
    var mapBody = <String, dynamic>{};
    var requestType = '';
    var url = '';
    params.apiCallsSelectedRequest!.forEach((final key, final dynamic value) {
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
        params.customHttpRequestExpectedStatusCode
            ?.toCode(
              loop,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '')
            .replaceAll(' ', '');
    final apiCallsResponseNameNew = params.apiCallsResponseName
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    var requestTypeToString = '';
    final hive = '''
    if (Hive.isBoxOpen('datasets')) {
      final box = Hive.box('datasets');
      await box.put('$apiCallsResponseNameNew',list ?? const <dynamic>[]);
    }
    ''';
    var toCode = '''''';
    if (requestType == 'Delete') {
      requestTypeToString = 'delete';
      toCode = '''
      final response = await TetaCMS.instance.httpRequest.$requestTypeToString('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,<String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];
      $hive
      ''';
    }
    if (requestType == 'Post') {
      requestTypeToString = 'post';
      toCode = '''
      final response = await TetaCMS.instance.httpRequest.$requestTypeToString('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,  <String, dynamic>$mapBodyString, <String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];
      $hive''';
    }
    if (requestType == 'Update') {
      requestTypeToString = 'update';
      toCode = '''
      final response = await TetaCMS.instance.httpRequest.$requestTypeToString('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,  <String, dynamic>$mapBodyString, <String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];
      $hive''';
    }
    if (requestType == 'Get') {
      requestTypeToString = 'get';
      toCode = '''
      final response = await TetaCMS.instance.httpRequest.$requestTypeToString('$url','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParametersString,  <String, dynamic>$mapBodyString, <String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
      datasets['$apiCallsResponseNameNew'] = list ?? const <dynamic>[];
      $hive''';
    }
    return toCode;
  }
}
