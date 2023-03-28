import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TASupabaseStorageDeleteParams implements TetaActionParams {
  const TASupabaseStorageDeleteParams({
    required this.supabaseFrom,
    required this.pathFile,
  });

  const TASupabaseStorageDeleteParams.empty()
      : supabaseFrom = null,
        pathFile = null;

  TASupabaseStorageDeleteParams.fromJson(final Map<String, dynamic> json)
      : supabaseFrom = json['sFrom'] != null
            ? FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>)
            : null,
        pathFile = json['vTTI'] != null
            ? FTextTypeInput.fromJson(json['vTTI'] as Map<String, dynamic>)
            : null;

  final FTextTypeInput? supabaseFrom;
  final FTextTypeInput? pathFile;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sFrom': supabaseFrom != null ? supabaseFrom!.toJson() : null,
        'vTTI': pathFile != null ? pathFile!.toJson() : null,
      };

  TASupabaseStorageDeleteParams copyWith({
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
  }) {
    return TASupabaseStorageDeleteParams(
      supabaseFrom: supabaseFrom ?? this.supabaseFrom,
      pathFile: pathFile ?? this.pathFile,
    );
  }
}
