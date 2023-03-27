import 'package:dart_airtable/dart_airtable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TASupabaseSignInWithProviderParams implements TetaActionParams {
  const TASupabaseSignInWithProviderParams({
    required this.nameOfPage,
    required this.paramsToSend,
    required this.provider,
  });

  const TASupabaseSignInWithProviderParams.empty()
      : nameOfPage = null,
        paramsToSend = null,
        provider = Provider.google;

  TASupabaseSignInWithProviderParams.fromJson(final Map<String, dynamic> json)
      : nameOfPage = json['pN'] as String?,
        paramsToSend = json['pTS'] as Map<String, dynamic>?,
        provider = Provider.values.firstWhereOrNull(
              (final Provider element) => element.name() == json['p'],
            ) ??
            Provider.google;

  final String? nameOfPage;
  final Map<String, dynamic>? paramsToSend;
  final Provider provider;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'pN': nameOfPage,
        'pTS': paramsToSend,
        'p': provider.name(),
      };
}
