import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TANavigationOpenSnackBarParams extends TetaActionParams {
  const TANavigationOpenSnackBarParams({
    required this.nameOfPage,
    required this.paramsToSend,
  });

  const TANavigationOpenSnackBarParams.empty()
      : nameOfPage = null,
        paramsToSend = null;

  TANavigationOpenSnackBarParams.fromJson(
    final Map<String, dynamic> json,
  ) : this(
          nameOfPage: json['pN'] as String?,
          paramsToSend: json['pTS'] as Map<String, dynamic>?,
        );

  final String? nameOfPage;
  final Map<String, dynamic>? paramsToSend;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'pN': nameOfPage,
        'pTS': paramsToSend,
      };
}
