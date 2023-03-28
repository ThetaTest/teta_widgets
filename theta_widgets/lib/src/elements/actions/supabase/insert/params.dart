import 'package:theta_models/theta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TASupabaseInsertParams implements TetaActionParams {
  const TASupabaseInsertParams({
    required this.supabaseFrom,
    required this.supabaseData,
  });

  const TASupabaseInsertParams.empty()
      : supabaseFrom = null,
        supabaseData = const [];

  TASupabaseInsertParams.fromJson(final Map<String, dynamic> json)
      : supabaseFrom = json['sFrom'] != null
            ? FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>)
            : null,
        supabaseData = (json['sData'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();

  final FTextTypeInput? supabaseFrom;
  final List<MapElement>? supabaseData;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sFrom': supabaseFrom != null ? supabaseFrom!.toJson() : null,
        'sData': supabaseData != null
            ? supabaseData!.map((final e) => e.toJson()).toList()
            : null
      };

  TASupabaseInsertParams copyWith({
    final FTextTypeInput? supabaseFrom,
    final List<MapElement>? supabaseData,
  }) {
    return TASupabaseInsertParams(
      supabaseFrom: supabaseFrom ?? this.supabaseFrom,
      supabaseData: supabaseData ?? this.supabaseData,
    );
  }
}
