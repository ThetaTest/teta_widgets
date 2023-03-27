import 'package:teta_models/teta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TASupabaseFunctionInvokeParams implements TetaActionParams {
  const TASupabaseFunctionInvokeParams({
    required this.supabaseFrom,
    required this.body,
    required this.headers,
    required this.supabaseEq,
  });

  const TASupabaseFunctionInvokeParams.empty()
      : supabaseFrom = null,
        body = const [],
        headers = const [],
        supabaseEq = null;

  TASupabaseFunctionInvokeParams.fromJson(final Map<String, dynamic> json)
      : supabaseFrom = json['sFrom'] != null
            ? FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>)
            : null,
        body = (json['sCustomHttpRequestBody'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
        headers =
            (json['sCustomHttpRequestHeader'] as List<dynamic>? ?? <dynamic>[])
                .map(
                  (final dynamic e) => MapElement.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
        supabaseEq = json['sEq'] != null
            ? MapElement.fromJson(json['sEq'] as Map<String, dynamic>)
            : null;

  final FTextTypeInput? supabaseFrom;
  final MapElement? supabaseEq;
  final List<MapElement>? body;
  final List<MapElement>? headers;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sFrom': supabaseFrom != null ? supabaseFrom!.toJson() : null,
        'sEq': supabaseEq?.toJson(),
        'sCustomHttpRequestBody':
            body != null ? body!.map((final e) => e.toJson()).toList() : null,
        'sCustomHttpRequestHeader': headers != null
            ? headers!.map((final e) => e.toJson()).toList()
            : null,
      };

  TASupabaseFunctionInvokeParams copyWith({
    final FTextTypeInput? supabaseFrom,
    final MapElement? supabaseEq,
    final List<MapElement>? body,
    final List<MapElement>? headers,
  }) {
    return TASupabaseFunctionInvokeParams(
      supabaseFrom: supabaseFrom ?? this.supabaseFrom,
      supabaseEq: supabaseEq ?? this.supabaseEq,
      body: body ?? this.body,
      headers: headers ?? this.headers,
    );
  }
}
