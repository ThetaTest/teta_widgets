import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAGoogleMapsUpdateLivePositionParams extends TetaActionParams {
  const TAGoogleMapsUpdateLivePositionParams({
    required this.latName,
    required this.lngName,
  });

  const TAGoogleMapsUpdateLivePositionParams.empty()
      : latName = null,
        lngName = null;

  // ignore: avoid_unused_constructor_parameters
  TAGoogleMapsUpdateLivePositionParams.fromJson(final Map<String, dynamic> json)
      : latName = json['latName'] as String?,
        lngName = json['lngName'] as String?;

  final String? latName;
  final String? lngName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'latName': latName,
        'lngName': lngName,
      };
}
