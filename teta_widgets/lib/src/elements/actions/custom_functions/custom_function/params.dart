import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TACustomFunctionParams extends TetaActionParams {
  const TACustomFunctionParams({
    required this.customFunctionId,
  });

  const TACustomFunctionParams.empty() : customFunctionId = null;

  TACustomFunctionParams.fromJson(final Map<String, dynamic> json)
      : customFunctionId = json['cFid'] as int?;

  final int? customFunctionId;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'cFid': customFunctionId};
}
