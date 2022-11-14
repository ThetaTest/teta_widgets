// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
// Package imports:
import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class FACustomHttpRequestPost {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? url,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final List<MapElement>? parameters,
    final List<MapElement>? body,
    final List<MapElement>? headers,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    DatasetObject _map = DatasetObject(
      name: 'Custom Http Request Post',
      map: [<String, dynamic>{}],
    );
    final urlNew = url?.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    final customHttpRequestExpectedStatusCodeNew =
        customHttpRequestExpectedStatusCode?.get(
      params,
      states,
      dataset,
      true,
      loop,
      context,
    );
    final mapParameters = <String, dynamic>{};
    for (final e in parameters ?? <MapElement>[]) {
      mapParameters[e.key] =
          e.value.get(params, states, dataset, true, loop, context);
    }
    final mapHeaders = <String, dynamic>{};
    for (final e in headers ?? <MapElement>[]) {
      mapHeaders[e.key] =
          e.value.get(params, states, dataset, true, loop, context);
    }
    final mapBody = <String, dynamic>{};
    for (final e in body ?? <MapElement>[]) {
      mapBody[e.key] =
          e.value.get(params, states, dataset, true, loop, context);
    }

    if (urlNew != null && customHttpRequestExpectedStatusCodeNew != null) {
      final response = await TetaCMS.instance.httpRequest.post(
          urlNew,
          customHttpRequestExpectedStatusCodeNew,
          mapParameters,
          mapBody,
          mapHeaders);
      if (response.data != null) {
        _map = _map.copyWith(
          name: 'Custom Http Request Post',
          map: (response.data ?? const <dynamic>[])
              .map((final dynamic e) => <String, dynamic>{...e})
              .toList(),
        );
      }
      if (response.error != null) {
        _map = _map.copyWith(
          name: 'Custom Http Request Post',
          map: (response.error! as List<dynamic>).map((final dynamic e) {
            return e as Map<String, dynamic>;
          }).toList(),
        );
      }

      final datasets = addDataset(context, dataset, _map);
    }
  }

  static String toCode(
    final FTextTypeInput? url,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final List<MapElement>? parameters,
    final List<MapElement>? body,
    final List<MapElement>? headers,
    final int? loop,
  ) {
    //parameters
    final mapParameters = <String, dynamic>{};
    for (final e in parameters ?? <MapElement>[]) {
      mapParameters[e.key] = e.value
          .toCode(
            0,
            resultType: ResultTypeEnum.string,
          )
          .replaceAll("'", '')
          .replaceAll(" ", '');
    }

    final mapParamatersString = StringBuffer()..write('{');
    for (final key in mapParameters.keys) {
      mapParamatersString.write("'$key': '${mapParameters[key]}',");
    }
    mapParamatersString.write('}');

    //headers
    final mapHeaders = <String, dynamic>{};
    for (final e in headers ?? <MapElement>[]) {
      var value = e.value
          .toCode(
            0,
            resultType: ResultTypeEnum.string,
          )
          .replaceAll("'", '');
      if (value.substring(value.length - 1) == ' ') {
        value = value.substring(0, value.length - 1);
      }

      mapHeaders[e.key] = value;
    }

    final mapHeadersString = StringBuffer()..write('{');
    for (final key in mapHeaders.keys) {
      mapHeadersString.write("'$key': '${mapHeaders[key]}',");
    }
    mapHeadersString.write('}');

    //body
    final mapBody = <String, dynamic>{};
    for (final e in body ?? <MapElement>[]) {
      mapBody[e.key] = e.value
          .toCode(
            0,
            resultType: ResultTypeEnum.string,
          )
          .replaceAll("'", '')
          .replaceAll(" ", '');
    }

    final mapBodyString = StringBuffer()..write('{');
    for (final key in mapBody.keys) {
      mapBodyString.write("'$key': '${mapBody[key]}',");
    }
    mapBodyString.write('}');

    //url
    final urlNew = url
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(" ", '');
    final customHttpRequestExpectedStatusCodeNew =
        customHttpRequestExpectedStatusCode
            ?.toCode(
              loop,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '')
            .replaceAll(" ", '');
    return '''final response = await TetaCMS.instance.httpRequest.post('$urlNew','$customHttpRequestExpectedStatusCodeNew', <String, dynamic>$mapParamatersString,  <String, dynamic>$mapBodyString, <String, dynamic>$mapHeadersString );
      List<dynamic>? list;
      if (response.data != null){  list = response.data as List<dynamic>?;};
      if (response.error != null){  list = response.error as List<dynamic>?;};
        datasets['Custom Http Request Post'] = list ?? const <dynamic>[];''';
  }
}
