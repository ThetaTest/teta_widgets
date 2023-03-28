import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAGoogleMapsReloadDataParams extends TetaActionParams {
  const TAGoogleMapsReloadDataParams({
    required this.mapsControllerName,
  });

  const TAGoogleMapsReloadDataParams.empty() : mapsControllerName = null;

  TAGoogleMapsReloadDataParams.fromJson(final Map<String, dynamic> json)
      : mapsControllerName = json['sN'] as String?;

  final String? mapsControllerName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': mapsControllerName,
      };
}
