import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../features/text_type_input.dart';

class TAStateChangeWithParams extends TetaActionParams {
  const TAStateChangeWithParams({
    required this.valueToChangeWith,
    required this.stateName,
    required this.isValueDefault,
  });

  const TAStateChangeWithParams.empty()
      : valueToChangeWith = null,
        stateName = null,
        isValueDefault = false;

  TAStateChangeWithParams.fromJson(final Map<String, dynamic> json)
      : valueToChangeWith = json['vTTI'] != null
            ? FTextTypeInput.fromJson(json['vTTI'] as Map<String, dynamic>)
            : null,
        stateName = json['sN'] as String?,
        isValueDefault = json['iVD'] as bool? ?? false;

  final FTextTypeInput? valueToChangeWith;
  final String? stateName;
  final bool isValueDefault;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'vTTI': valueToChangeWith?.toJson(),
        'sN': stateName,
        'iVD': isValueDefault,
      };
}
