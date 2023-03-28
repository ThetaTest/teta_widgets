import 'package:theta_models/theta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TACustomHttpRequestUpdateParams extends TetaActionParams {
  const TACustomHttpRequestUpdateParams({
    required this.url,
    required this.expectedStatusCode,
    required this.parameters,
    required this.headers,
    required this.body,
    required this.responseState,
  });

  const TACustomHttpRequestUpdateParams.empty()
      : url = null,
        expectedStatusCode = null,
        parameters = null,
        headers = null,
        body = null,
        responseState = null;

  TACustomHttpRequestUpdateParams.fromJson(final Map<String, dynamic> json)
      : url = FTextTypeInput.fromJson(
          json['sCustomHttpRequestURL'] as Map<String, dynamic>?,
        ),
        expectedStatusCode = FTextTypeInput.fromJson(
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
            .toList(),
        responseState = json['sN'] as String?;

  final FTextTypeInput? url;
  final FTextTypeInput? expectedStatusCode;
  final List<MapElement>? parameters;
  final List<MapElement>? headers;
  final List<MapElement>? body;
  final String? responseState;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sCustomHttpRequestExpectedStatusCode': expectedStatusCode?.toJson(),
        'sCustomHttpRequestURL': url?.toJson(),
        'sCustomHttpRequestHeader':
            headers?.map((final e) => e.toJson()).toList(),
        'sCustomHttpRequestList':
            parameters?.map((final e) => e.toJson()).toList(),
        'sCustomHttpRequestBody': body?.map((final e) => e.toJson()).toList(),
        'sN': responseState,
      };

  TACustomHttpRequestUpdateParams copyWith({
    final FTextTypeInput? url,
    final FTextTypeInput? expectedStatusCode,
    final List<MapElement>? parameters,
    final List<MapElement>? headers,
    final List<MapElement>? body,
    final String? responseState,
  }) =>
      TACustomHttpRequestUpdateParams(
        url: url ?? this.url,
        expectedStatusCode: expectedStatusCode ?? this.expectedStatusCode,
        parameters: parameters ?? this.parameters,
        headers: headers ?? this.headers,
        body: body ?? this.body,
        responseState: responseState ?? this.responseState,
      );
}
