import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAGoogleMapsSetCameraPositionParams extends TetaActionParams {
  const TAGoogleMapsSetCameraPositionParams({
    required this.stateName,
    required this.lat,
    required this.lng,
    required this.zoom,
  });

  const TAGoogleMapsSetCameraPositionParams.empty()
      : stateName = null,
        lat = '',
        lng = '',
        zoom = '';

  TAGoogleMapsSetCameraPositionParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?,
        lat = json['googleMapsLat'] as String,
        lng = json['googleMapsLng'] as String,
        zoom = json['googleMapsZoom'] as String;

  final String? stateName;
  final String lat;
  final String lng;
  final String zoom;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
        'googleMapsLat': lat,
        'googleMapsLng': lng,
        'googleMapsZoom': zoom,
      };
}
