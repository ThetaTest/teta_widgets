import 'package:teta_models/teta_models.dart';
import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TASupabaseOnInsertParams implements TetaActionParams {
  const TASupabaseOnInsertParams({
    required this.supabaseFrom,
    required this.stateName,
    required this.supabaseData,
  });

  const TASupabaseOnInsertParams.empty()
      : supabaseFrom = null,
        stateName = null,
        supabaseData = const [];

  TASupabaseOnInsertParams.fromJson(final Map<String, dynamic> json)
      : supabaseFrom = json['sFrom'] != null
            ? FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>)
            : null,
        stateName = json['sN'] as String,
        supabaseData = (json['sData'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();

  final FTextTypeInput? supabaseFrom;
  final String? stateName;
  final List<MapElement>? supabaseData;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sFrom': supabaseFrom != null ? supabaseFrom!.toJson() : null,
        'sN': stateName,
        'sData': supabaseData != null
            ? supabaseData!.map((final e) => e.toJson()).toList()
            : null,
      };
}
