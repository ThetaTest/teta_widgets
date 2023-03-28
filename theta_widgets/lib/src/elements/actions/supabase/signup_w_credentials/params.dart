import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TASupabaseSignUpParams implements TetaActionParams {
  const TASupabaseSignUpParams({
    required this.nameOfPage,
    required this.paramsToSend,
  });

  const TASupabaseSignUpParams.empty()
      : nameOfPage = null,
        paramsToSend = null;

  TASupabaseSignUpParams.fromJson(final Map<String, dynamic> json)
      : nameOfPage = json['pN'] as String?,
        paramsToSend = json['pTS'] as Map<String, dynamic>?;

  final String? nameOfPage;
  final Map<String, dynamic>? paramsToSend;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'pN': nameOfPage,
        'pTS': paramsToSend,
      };
}
