import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAWebViewGoBackParams extends TetaActionParams {
  const TAWebViewGoBackParams({
    required this.stateName,
  });

  const TAWebViewGoBackParams.empty() : stateName = null;

  TAWebViewGoBackParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
