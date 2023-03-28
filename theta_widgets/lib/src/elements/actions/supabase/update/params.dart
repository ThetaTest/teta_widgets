import 'package:theta_models/theta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TASupabaseUpdateParams implements TetaActionParams {
  const TASupabaseUpdateParams({
    required this.supabaseFrom,
    required this.supabaseData,
    required this.supabaseEq,
  });

  TASupabaseUpdateParams.empty()
      : supabaseFrom = null,
        supabaseData = const [],
        supabaseEq = null;

  TASupabaseUpdateParams.fromJson(final Map<String, dynamic> json)
      : supabaseFrom = FTextTypeInput.fromJson(
          json['sFrom'] as Map<String, dynamic>?,
        ),
        supabaseData = (json['sData'] as List? ?? [])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
        supabaseEq = json['sEq'] != null
            ? MapElement.fromJson(json['sEq'] as Map<String, dynamic>)
            : null;

  final FTextTypeInput? supabaseFrom;
  final MapElement? supabaseEq;
  final List<MapElement>? supabaseData;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sFrom': supabaseFrom?.toJson(),
        'sEq': supabaseEq?.toJson(),
        'sData': supabaseData?.map((final MapElement e) => e.toJson()).toList(),
      };

  TASupabaseUpdateParams copyWith({
    final FTextTypeInput? supabaseFrom,
    final MapElement? supabaseEq,
    final List<MapElement>? supabaseData,
  }) {
    return TASupabaseUpdateParams(
      supabaseFrom: supabaseFrom ?? this.supabaseFrom,
      supabaseEq: supabaseEq ?? this.supabaseEq,
      supabaseData: supabaseData ?? this.supabaseData,
    );
  }
}
