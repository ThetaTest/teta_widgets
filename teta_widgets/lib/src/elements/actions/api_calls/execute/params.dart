import 'package:teta_models/teta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../features/text_type_input.dart';

class TAApiCallsExecuteParams implements TetaActionParams {
  const TAApiCallsExecuteParams({
    required this.apiCallsRequestName,
    required this.apiCallsSelectedRequest,
    required this.customHttpRequestExpectedStatusCode,
    required this.apiCallsResponseName,
    required this.apiCallsDynamicValue,
  });

  const TAApiCallsExecuteParams.empty()
      : apiCallsRequestName = null,
        apiCallsSelectedRequest = null,
        customHttpRequestExpectedStatusCode = null,
        apiCallsResponseName = null,
        apiCallsDynamicValue = const [];

  TAApiCallsExecuteParams.fromJson(final Map<String, dynamic> json)
      : apiCallsRequestName = json['aCRN'] as String?,
        apiCallsSelectedRequest = json['aCSR'] as Map<String, dynamic>?,
        customHttpRequestExpectedStatusCode = FTextTypeInput.fromJson(
          json['sCustomHttpRequestExpectedStatusCode'] as Map<String, dynamic>?,
        ),
        apiCallsResponseName = FTextTypeInput.fromJson(
          json['aCResN'] as Map<String, dynamic>?,
        ),
        apiCallsDynamicValue =
            (json['sApiCallsDynamicValue'] as List<dynamic>? ?? <dynamic>[])
                .map(
                  (final dynamic e) => MapElement.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();

  final String? apiCallsRequestName;
  final Map<String, dynamic>? apiCallsSelectedRequest;
  final FTextTypeInput? customHttpRequestExpectedStatusCode;
  final FTextTypeInput? apiCallsResponseName;
  final List<MapElement>? apiCallsDynamicValue;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'aCRN': apiCallsRequestName,
        'aCSR': apiCallsSelectedRequest,
        'sCustomHttpRequestExpectedStatusCode':
            customHttpRequestExpectedStatusCode?.toJson(),
        'aCResN': apiCallsResponseName?.toJson(),
        'sApiCallsDynamicValue': apiCallsDynamicValue
            ?.map(
              (final e) => e.toJson(),
            )
            .toList()
      };

  TAApiCallsExecuteParams copyWith({
    final String? apiCallsRequestName,
    final Map<String, dynamic>? apiCallsSelectedRequest,
    final FTextTypeInput? customHttpRequestExpectedStatusCode,
    final FTextTypeInput? apiCallsResponseName,
    final List<MapElement>? apiCallsDynamicValue,
  }) =>
      TAApiCallsExecuteParams(
        apiCallsRequestName: apiCallsRequestName ?? this.apiCallsRequestName,
        apiCallsSelectedRequest:
            apiCallsSelectedRequest ?? this.apiCallsSelectedRequest,
        customHttpRequestExpectedStatusCode:
            customHttpRequestExpectedStatusCode ??
                this.customHttpRequestExpectedStatusCode,
        apiCallsResponseName: apiCallsResponseName ?? this.apiCallsResponseName,
        apiCallsDynamicValue: apiCallsDynamicValue ?? this.apiCallsDynamicValue,
      );
}
