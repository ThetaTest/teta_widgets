import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TABraintreeBuyParams extends TetaActionParams {
  const TABraintreeBuyParams({
    required this.stateName,
    this.valueToChangeWith,
  });

  const TABraintreeBuyParams.empty()
      : stateName = null,
        valueToChangeWith = null;

  TABraintreeBuyParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?,
        valueToChangeWith = json['vTTI'] != null
            ? FTextTypeInput.fromJson(json['vTTI'] as Map<String, dynamic>)
            : null;

  final String? stateName;
  final FTextTypeInput? valueToChangeWith;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
        'vTTI': valueToChangeWith?.toJson(),
      };
}
