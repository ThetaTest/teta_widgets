import 'package:theta_models/theta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TASupabaseDeleteParams implements TetaActionParams {
  const TASupabaseDeleteParams({
    required this.supabaseFrom,
    required this.supabaseEq,
  });

  TASupabaseDeleteParams.empty()
      : supabaseFrom = null,
        supabaseEq = null;

  TASupabaseDeleteParams.fromJson(final Map<String, dynamic> json)
      : supabaseFrom = json['sFrom'] != null
            ? FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>)
            : null,
        supabaseEq = json['sEq'] != null
            ? MapElement.fromJson(json['sEq'] as Map<String, dynamic>)
            : null;

  final FTextTypeInput? supabaseFrom;
  final MapElement? supabaseEq;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sFrom': supabaseFrom != null ? supabaseFrom!.toJson() : null,
        'sEq': supabaseEq?.toJson(),
      };

  TASupabaseDeleteParams copyWith({
    final FTextTypeInput? supabaseFrom,
    final MapElement? supabaseEq,
  }) {
    return TASupabaseDeleteParams(
      supabaseFrom: supabaseFrom ?? this.supabaseFrom,
      supabaseEq: supabaseEq ?? this.supabaseEq,
    );
  }
}
