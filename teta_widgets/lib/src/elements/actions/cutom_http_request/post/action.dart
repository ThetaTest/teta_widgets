import 'package:flutter/material.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_value.dart';
import 'package:teta_widgets/src/elements/index.dart';

import '../../../../core/teta_action/index.dart';
import 'params.dart';

class TACustomHttpRequestPost extends TetaAction {
  TACustomHttpRequestPost({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TACustomHttpRequestPost.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TACustomHttpRequestPostParams.fromJson(
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
  TACustomHttpRequestPostParams get params =>
      super.params as TACustomHttpRequestPostParams;

  @override
  TetaActionType get type => TetaActionType.customHttpPost;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    var map = const DatasetObject(
      name: 'Custom Http Request Post',
      map: [<String, dynamic>{}],
    );
    final url = params.url?.get(
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
    final mapBody = <String, dynamic>{};
    for (final e in params.body ?? <MapElement>[]) {
      mapBody[e.key] = e.value.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
    }
    if (url != null && expectedStatusCode != null) {
      final response = await TetaCMS.instance.httpRequest.post(
        url,
        expectedStatusCode,
        mapParameters,
        mapBody,
        mapHeaders,
      );
      if (response.data != null) {
        map = map.copyWith(
          name: 'Custom Http Request Post',
          map: (response.data ?? const <dynamic>[])
              .map((final dynamic e) => <String, dynamic>{...e})
              .toList(),
        );
      }
      if (response.error != null) {
        map = map.copyWith(
          name: 'Custom Http Request Post',
          map: (response.error!).map((final dynamic e) {
            return e as Map<String, dynamic>;
          }).toList(),
        );
      }

      if (params.responseState != null) {
        updateStateValue(context, params.responseState!, map.getMap[0]);
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
    for (final e in params.body ?? <MapElement>[]) {
      mapBody[e.key] = e.value
          .toCode(
            0,
            resultType: ResultTypeEnum.string,
          )
          .replaceAll("'", '')
          .replaceAll(' ', '');
    }

    final mapBodyString = StringBuffer()..write('{');
    for (final key in mapBody.keys) {
      mapBodyString.write("'$key': '${mapBody[key]}',");
    }
    mapBodyString.write('}');

    //url
    final urlNew = params.url
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    final customHttpRequestExpectedStatusCodeNew = params.expectedStatusCode
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    return '''
      final response = await TetaCMS.instance.httpRequest.post(
        '$urlNew',
        '$customHttpRequestExpectedStatusCodeNew',
        <String, dynamic>$mapParamatersString,
        <String, dynamic>$mapBodyString,
        <String, dynamic>$mapHeadersString,
      );

      List<dynamic>? list;
      if (response.data != null) {
        list = response.data as List<dynamic>?;
      };
      if (response.error != null) {
        list = response.error as List<dynamic>?;
      };
      datasets['Custom Http Request Post'] = list ?? const <dynamic>[];
      ''';
  }
}
