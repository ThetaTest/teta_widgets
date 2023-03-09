// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';

class FASupabaseFunctionsInvoke {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final List<MapElement>? body,
    final List<MapElement>? headers,
    final int? loop,
  ) async {
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;

    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final name = supabaseFrom?.get(
            pageState.params,
            pageState.states,
            pageState.datasets,
            true,
            loop,
            context,
          ) ??
          '';
      if (name == '') return;
      var _map = DatasetObject(
        name: 'Supabase func $name',
        map: const [<String, dynamic>{}],
      );
      final mapHeaders = <String, String>{};
      for (final e in headers ?? <MapElement>[]) {
        mapHeaders[e.key] = e.value.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          loop,
          context,
        );
      }
      final mapBody = <String, String>{};
      for (final e in body ?? <MapElement>[]) {
        mapBody[e.key] = e.value.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          loop,
          context,
        );
      }

      final response = await client.functions.invoke(
        name,
        headers: mapHeaders,
        body: mapBody,
      );
      if (response.data != null) {
        _map = _map.copyWith(
          name: 'Supabase func $name',
          map: (response.data is List<dynamic>)
              ? List.from(
                  (response.data as List<dynamic>? ?? const <dynamic>[])
                      .map(
                        (final dynamic e) =>
                            <String, dynamic>{...e as Map<String, dynamic>},
                      )
                      .toList(),
                )
              : [
                  if (response.data is Map<String, dynamic>)
                    <String, dynamic>{...response.data as Map<String, dynamic>}
                ],
        );
      }
      if (response.error != null) {
        _map = _map.copyWith(
          name: 'Supabase func $name',
          map: (response.error! as List<dynamic>? ?? <dynamic>[])
              .map((final dynamic e) {
            return e as Map<String, dynamic>;
          }).toList(),
        );
      }
      final datasets = addDataset(context, _map);
    }
  }

  static String toCode(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final List<MapElement>? body,
    final List<MapElement>? headers,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
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
            .replaceAll(' ', '');
      }

      final mapBodyString = StringBuffer()..write('{');
      for (final key in mapBody.keys) {
        mapBodyString.write("'$key': '${mapBody[key]}',");
      }
      mapBodyString.write('}');
      final name = supabaseFrom?.toCode(
            0,
            resultType: ResultTypeEnum.string,
            defaultValue: '',
          ) ??
          '';
      return '''
        final response = await Supabase.instance.client.functions.invoke($name, 
          body: <String, String>$mapBodyString, 
          headers: <String, String>$mapHeadersString,
        );
        List<dynamic>? list;
        if (response.error != null) {
          datasets['Supabase func ${name.replaceAll("'", '')}'] = (response.error! as List<dynamic>? ?? <dynamic>[]).map((final dynamic e) {
            return e as Map<String, dynamic>;
          }).toList();
          ${status != null ? "setState(() { status = 'Failed'; });" : ''}
        } else {
          datasets['Supabase func ${name.replaceAll("'", '')}'] = (response.data is List<dynamic>)
              ? List.from(
                  (response.data as List<dynamic>? ?? const <dynamic>[])
                      .map(
                        (final dynamic e) =>
                            <String, dynamic>{...e as Map<String, dynamic>},
                      )
                      .toList(),
                )
              : [
                  if (response.data is Map<String, dynamic>)
                    <String, dynamic>{...response.data as Map<String, dynamic>}
                ];
          ${status != null ? "setState(() { status = 'Success'; });" : ''}
        }
      ''';
    } else {
      return '';
    }
  }
}
