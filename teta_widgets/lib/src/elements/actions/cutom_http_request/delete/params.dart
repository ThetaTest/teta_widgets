import 'package:teta_models/teta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TACustomHttpRequestDeleteParams extends TetaActionParams {
  const TACustomHttpRequestDeleteParams({
    required this.url,
    required this.expectedStatusCode,
    required this.parameters,
    required this.headers,
  });

  const TACustomHttpRequestDeleteParams.empty()
      : url = null,
        expectedStatusCode = null,
        parameters = null,
        headers = null;

  TACustomHttpRequestDeleteParams.fromJson(final Map<String, dynamic> json)
      : url = FTextTypeInput.fromJson(
          json['customHttpRequestURL'] as Map<String, dynamic>?,
        ),
        expectedStatusCode = FTextTypeInput.fromJson(
          json['expectedStatusCode'] as Map<String, dynamic>?,
        ),
        parameters =
            (json['customHttpRequestList'] as List<dynamic>? ?? <dynamic>[])
                .map(
                  (final dynamic e) => MapElement.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
        headers =
            (json['customHttpRequestHeader'] as List<dynamic>? ?? <dynamic>[])
                .map(
                  (final dynamic e) => MapElement.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();

  final FTextTypeInput? url;
  final FTextTypeInput? expectedStatusCode;
  final List<MapElement>? parameters;
  final List<MapElement>? headers;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'expectedStatusCode': expectedStatusCode?.toJson(),
        'customHttpRequestURL': url?.toJson(),
        'customHttpRequestHeader':
            headers?.map((final e) => e.toJson()).toList(),
        'customHttpRequestList':
            parameters?.map((final e) => e.toJson()).toList(),
      };

  TACustomHttpRequestDeleteParams copyWith({
    final FTextTypeInput? url,
    final FTextTypeInput? expectedStatusCode,
    final List<MapElement>? parameters,
    final List<MapElement>? headers,
  }) {
    return TACustomHttpRequestDeleteParams(
      url: url ?? this.url,
      expectedStatusCode: expectedStatusCode ?? this.expectedStatusCode,
      parameters: parameters ?? this.parameters,
      headers: headers ?? this.headers,
    );
  }
}
