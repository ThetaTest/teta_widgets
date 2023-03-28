import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TANavigationOpenPageParams extends TetaActionParams {
  const TANavigationOpenPageParams({
    required this.nameOfPage,
    required this.paramsToSend,
  });

  const TANavigationOpenPageParams.empty()
      : nameOfPage = null,
        paramsToSend = null;

  TANavigationOpenPageParams.fromJson(
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

  TANavigationOpenPageParams copyWith({
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  }) =>
      TANavigationOpenPageParams(
        nameOfPage: nameOfPage ?? this.nameOfPage,
        paramsToSend: paramsToSend ?? this.paramsToSend,
      );
}
