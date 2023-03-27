import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TASupabaseStorageUploadParams implements TetaActionParams {
  const TASupabaseStorageUploadParams({
    required this.supabaseFrom,
    required this.pathFile,
    required this.stateName,
    required this.stateName2,
  });

  const TASupabaseStorageUploadParams.empty()
      : supabaseFrom = null,
        pathFile = null,
        stateName = null,
        stateName2 = null;

  TASupabaseStorageUploadParams.fromJson(final Map<String, dynamic> json)
      : supabaseFrom = json['sFrom'] != null
            ? FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>)
            : null,
        pathFile = json['vTTI'] != null
            ? FTextTypeInput.fromJson(json['vTTI'] as Map<String, dynamic>)
            : null,
        stateName = json['sN'] as String?,
        stateName2 = json['sN2'] as String?;

  final FTextTypeInput? supabaseFrom;
  final FTextTypeInput? pathFile;
  final String? stateName;
  final String? stateName2;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sFrom': supabaseFrom != null ? supabaseFrom!.toJson() : null,
        'vTTI': pathFile != null ? pathFile!.toJson() : null,
        'sN': stateName,
        'sN2': stateName2,
      };

  TASupabaseStorageUploadParams copyWith({
    final FTextTypeInput? supabaseFrom,
    final FTextTypeInput? pathFile,
    final String? stateName,
    final String? stateName2,
  }) {
    return TASupabaseStorageUploadParams(
      supabaseFrom: supabaseFrom ?? this.supabaseFrom,
      pathFile: pathFile ?? this.pathFile,
      stateName: stateName ?? this.stateName,
      stateName2: stateName2 ?? this.stateName2,
    );
  }
}
