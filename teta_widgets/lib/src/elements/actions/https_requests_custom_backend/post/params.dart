import 'package:teta_models/teta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TACustomHttpRequestPostParams extends TetaActionParams {
  const TACustomHttpRequestPostParams({
    required this.url,
    required this.customHttpRequestExpectedStatusCode,
    required this.parameters,
    required this.headers,
    required this.body,
  });

  const TACustomHttpRequestPostParams.empty()
      : url = null,
        customHttpRequestExpectedStatusCode = null,
        parameters = null,
        headers = null,
        body = null;

  TACustomHttpRequestPostParams.fromJson(final Map<String, dynamic> json)
      : url = FTextTypeInput.fromJson(
          json['sCustomHttpRequestURL'] as Map<String, dynamic>?,
        ),
        customHttpRequestExpectedStatusCode = FTextTypeInput.fromJson(
          json['sCustomHttpRequestExpectedStatusCode'] as Map<String, dynamic>?,
        ),
        parameters =
            (json['sCustomHttpRequestList'] as List<dynamic>? ?? <dynamic>[])
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
        body = (json['sCustomHttpRequestBody'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();

  final FTextTypeInput? url;
  final FTextTypeInput? customHttpRequestExpectedStatusCode;
  final List<MapElement>? parameters;
  final List<MapElement>? headers;
  final List<MapElement>? body;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sCustomHttpRequestExpectedStatusCode':
            customHttpRequestExpectedStatusCode?.toJson(),
        'sCustomHttpRequestURL': url?.toJson(),
        'sCustomHttpRequestHeader':
            headers?.map((final e) => e.toJson()).toList(),
        'sCustomHttpRequestList':
            parameters?.map((final e) => e.toJson()).toList(),
        'sCustomHttpRequestBody': body?.map((final e) => e.toJson()).toList(),
      };

  TACustomHttpRequestPostParams copyWith({
    final FTextTypeInput? url,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final List<MapElement>? parameters,
    final List<MapElement>? headers,
    final List<MapElement>? body,
  }) =>
      TACustomHttpRequestPostParams(
        url: url ?? this.url,
        customHttpRequestExpectedStatusCode:
            customHttpRequestExpectedStatusCode ??
                this.customHttpRequestExpectedStatusCode,
        parameters: parameters ?? this.parameters,
        headers: headers ?? this.headers,
        body: body ?? this.body,
      );
}
