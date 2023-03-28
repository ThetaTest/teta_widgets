import '../../../../../core/teta_action/action_options/teta_action_params.dart';

class TATetaCMSLogoutParams implements TetaActionParams {
  const TATetaCMSLogoutParams({
    required this.nameOfPage,
    required this.paramsToSend,
  });

  TATetaCMSLogoutParams.fromJson(final Map<String, dynamic> json)
      : nameOfPage = json['pN'] as String?,
        paramsToSend = json['pTS'] as Map<String, dynamic>?;

  const TATetaCMSLogoutParams.empty()
      : nameOfPage = null,
        paramsToSend = null;

  final String? nameOfPage;
  final Map<String, dynamic>? paramsToSend;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'pN': nameOfPage,
        'pTS': paramsToSend,
      };

  TATetaCMSLogoutParams copyWith({
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  }) {
    return TATetaCMSLogoutParams(
      nameOfPage: nameOfPage ?? this.nameOfPage,
      paramsToSend: paramsToSend ?? this.paramsToSend,
    );
  }
}
