import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TACameraTakePhotoParams extends TetaActionParams {
  const TACameraTakePhotoParams({
    required this.stateName,
  });

  const TACameraTakePhotoParams.empty() : stateName = null;

  TACameraTakePhotoParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'sN': stateName};

  TACameraTakePhotoParams copyWith({
    final String? stateName,
  }) {
    return TACameraTakePhotoParams(
      stateName: stateName ?? this.stateName,
    );
  }
}
