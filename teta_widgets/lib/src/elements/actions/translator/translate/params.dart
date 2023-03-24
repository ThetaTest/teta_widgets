import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TATranslatorTranslateParams implements TetaActionParams {
  const TATranslatorTranslateParams({
    required this.stateName,
  });

  const TATranslatorTranslateParams.empty() : stateName = null;

  TATranslatorTranslateParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
