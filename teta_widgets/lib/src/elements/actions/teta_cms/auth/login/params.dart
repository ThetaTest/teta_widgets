import 'package:teta_cms/teta_cms.dart';
import '../../../../../core/teta_action/action_options/teta_action_params.dart';

class TATetaCMSLoginParams implements TetaActionParams {
  const TATetaCMSLoginParams({
    required this.provider,
    required this.nameOfPage,
    required this.paramsToSend,
  });

  const TATetaCMSLoginParams.empty()
      : provider = TetaProvider.google,
        nameOfPage = null,
        paramsToSend = null;

  TATetaCMSLoginParams.fromJson(final Map<String, dynamic> json)
      : provider = TetaProvider.values.firstWhere(
          (final TetaProvider e) => e.toString() == json['provider'],
        ),
        nameOfPage = json['pN'] as String?,
        paramsToSend = json['pTS'] as Map<String, dynamic>?;

  final TetaProvider provider;
  final String? nameOfPage;
  final Map<String, dynamic>? paramsToSend;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'provider': provider.toString(),
        'pN': nameOfPage,
        'pTS': paramsToSend,
      };

  TATetaCMSLoginParams copyWith({
    final TetaProvider? provider,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  }) =>
      TATetaCMSLoginParams(
        provider: provider ?? this.provider,
        nameOfPage: nameOfPage ?? this.nameOfPage,
        paramsToSend: paramsToSend ?? this.paramsToSend,
      );
}
