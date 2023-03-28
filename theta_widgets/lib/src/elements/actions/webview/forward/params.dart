import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAWebViewGoForwardParams extends TetaActionParams {
  const TAWebViewGoForwardParams({
    required this.stateName,
  });

  const TAWebViewGoForwardParams.empty() : stateName = null;

  TAWebViewGoForwardParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
