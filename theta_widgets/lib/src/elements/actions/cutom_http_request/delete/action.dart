import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:theta_models/theta_models.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';

import '../../../../core/teta_action/index.dart';
import '../../snippets/update_state_value.dart';
import 'params.dart';

class TACustomHttpRequestDelete extends TetaAction {
  TACustomHttpRequestDelete({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TACustomHttpRequestDelete.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TACustomHttpRequestDeleteParams.fromJson(
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
  TACustomHttpRequestDeleteParams get params =>
      super.params as TACustomHttpRequestDeleteParams;

  @override
  TetaActionType get type => TetaActionType.customHttpDelete;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    var _map = const DatasetObject(
      name: 'Custom Http Request Delete',
      map: [<String, dynamic>{}],
    );
    final urlNew = params.url?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    final expectedStatusCode = params.expectedStatusCode?.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
      context,
    );
    final mapParameters = <String, dynamic>{};
    for (final e in params.parameters ?? <MapElement>[]) {
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
    for (final e in params.headers ?? <MapElement>[]) {
      mapHeaders[e.key] = e.value.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
    }

    if (urlNew != null && expectedStatusCode != null) {
      final response = await TetaCMS.instance.httpRequest.delete(
        urlNew,
        expectedStatusCode,
        mapParameters,
        mapHeaders,
      );
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
          map: (response.error!).map((final dynamic e) {
            return e as Map<String, dynamic>;
          }).toList(),
        );
      }

      if (params.responseState != null) {
        updateStateValue(context, params.responseState!, _map.getMap[0]);
      }
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    //parameters
    final mapParameters = <String, dynamic>{};
    for (final e in params.parameters ?? <MapElement>[]) {
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
    for (final e in params.headers ?? <MapElement>[]) {
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
    final urlNew = params.url
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    final expectedStatusCode = params.expectedStatusCode
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');

    return '''
      final response =await TetaCMS.instance.httpRequest.delete(
        '$urlNew',
        '$expectedStatusCode',
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
