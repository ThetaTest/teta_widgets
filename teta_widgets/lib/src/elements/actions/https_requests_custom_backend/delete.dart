// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
// Package imports:
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class FACustomHttpRequestDelete {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final FTextTypeInput? url,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final List<MapElement>? parameters,
    final List<MapElement>? headers,
  ) async {
    var _map = DatasetObject(
      name: 'Custom Http Request Delete',
      map: [<String, dynamic>{}],
    );
    final urlNew = url?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    final customHttpRequestExpectedStatusCodeNew =
        customHttpRequestExpectedStatusCode?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    final mapParameters = <String, dynamic>{};
    for (final e in parameters ?? <MapElement>[]) {
      mapParameters[e.key] = e.value.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
    }
    final mapHeaders = <String, dynamic>{};
    for (final e in headers ?? <MapElement>[]) {
      mapHeaders[e.key] = e.value.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
    }

    if (urlNew != null && customHttpRequestExpectedStatusCodeNew != null) {
      final response = await TetaCMS.instance.httpRequest.delete(urlNew,
          customHttpRequestExpectedStatusCodeNew, mapParameters, mapHeaders);
      if (response.data != null) {
        _map = _map.copyWith(
          name: 'Custom Http Request Delete',
          map: (response.data ?? const <dynamic>[])
              .map((final dynamic e) => <String, dynamic>{...e})
              .toList(),
        );
      }
      if (response.error != null) {
        _map = _map.copyWith(
          name: 'Custom Http Request Delete',
          map: (response.error! as List<dynamic>).map((final dynamic e) {
            return e as Map<String, dynamic>;
          }).toList(),
        );
      }
      final datasets = addDataset(context, _map);
    }
  }

  static String toCode(
    final FTextTypeInput? url,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final List<MapElement>? parameters,
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
          .replaceAll(' ', '');
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
      //delete last chat(white space) in string.
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

    //url
    final urlNew = url
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    final customHttpRequestExpectedStatusCodeNew =
        customHttpRequestExpectedStatusCode
            ?.toCode(
              loop,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '')
            .replaceAll(' ', '');

    return '''
      final response =await TetaCMS.instance.httpRequest.delete(
        '$urlNew',
        '$customHttpRequestExpectedStatusCodeNew',
        <String, dynamic>$mapParamatersString,
        <String, dynamic>$mapHeadersString,
      );
      List<dynamic>? list;
      if (response.data != null) {
        list = response.data as List<dynamic>?;
      };
      if (response.error != null) {
        list = response.error as List<dynamic>?;
      };
      datasets['Custom Http Request Delete'] = list ?? const <dynamic>[];
      ''';
  }
}
