import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAWebViewReloadParams extends TetaActionParams {
  const TAWebViewReloadParams({
    required this.stateName,
  });

  const TAWebViewReloadParams.empty() : stateName = null;

  TAWebViewReloadParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
