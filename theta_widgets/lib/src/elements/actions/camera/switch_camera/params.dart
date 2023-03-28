import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TACameraSwitchCameraParams extends TetaActionParams {
  const TACameraSwitchCameraParams({
    required this.nameOfPage,
    required this.paramsToSend,
  });

  const TACameraSwitchCameraParams.empty()
      : nameOfPage = null,
        paramsToSend = null;

  TACameraSwitchCameraParams.fromJson(final Map<String, dynamic> json)
      : nameOfPage = json['pN'] as String,
        paramsToSend = json['pTS'] as Map<String, dynamic>?;

  final String? nameOfPage;
  final Map<String, dynamic>? paramsToSend;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'pN': nameOfPage,
        'pTS': paramsToSend,
      };
}
