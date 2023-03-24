import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../builder/add_dataset.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TASupabaseFunctionInvoke extends TetaAction {
  TASupabaseFunctionInvoke({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TASupabaseFunctionInvoke.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TASupabaseFunctionInvokeParams.fromJson(
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
  TASupabaseFunctionInvokeParams get params =>
      super.params as TASupabaseFunctionInvokeParams;

  @override
  TetaActionType get type => TetaActionType.supabaseFunctionInvoke;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final pageState = BlocProvider.of<PageCubit>(context).state;
    if (pageState is! PageLoaded) return;

    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
      final name = params.supabaseFrom?.get(
            pageState.params,
            pageState.states,
            pageState.datasets,
            true,
            state.loop,
            context,
          ) ??
          '';
      if (name == '') return;
      var _map = DatasetObject(
        name: 'Supabase func $name',
        map: const [<String, dynamic>{}],
      );
      final mapHeaders = <String, String>{};
      for (final e in params.headers ?? <MapElement>[]) {
        mapHeaders[e.key] = e.value.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          state.loop,
          context,
        );
      }
      final mapBody = <String, String>{};
      for (final e in params.body ?? <MapElement>[]) {
        mapBody[e.key] = e.value.get(
          pageState.params,
          pageState.states,
          pageState.datasets,
          true,
          state.loop,
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

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    final status = takeStateFrom(page, 'status');
    final client = BlocProvider.of<SupabaseCubit>(context).state;
    if (client != null) {
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
      final name = params.supabaseFrom?.toCode(
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
