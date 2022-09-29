// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/map_style.dart';

///
class FGoogleMapsMapStyle {
  /// Constructor
  FGoogleMapsMapStyle({
    final MapStyle style = MapStyle.standard,
  }) : _style = style;

  MapStyle _style;

  /// Returns current value
  MapStyle get get => _style;

  /// Returns a String value for DropDowns' value
  String get getString => _convertValueToDropDown(_style);

  /// Sets a new value for [_style]
  /// Requires a String value
  void set(final String text) => _style = _convertDropDownToValue(text);

  /// Instantiate [FGoogleMapsMapStyle] from Json
  FGoogleMapsMapStyle fromJson(final String json) {
    try {
      return FGoogleMapsMapStyle(
        style: _convertJsonToValue(json),
      );
    } catch (e) {
      return this;
    }
  }

  /// Returns Json from actual value
  String toJson() {
    return _convertValueToJson(_style);
  }

  static MapStyle _convertJsonToValue(final String key) {
    if (key == 'standard') return MapStyle.standard;
    if (key == 'silver') return MapStyle.silver;
    if (key == 'retro') return MapStyle.retro;
    if (key == 'dark') return MapStyle.dark;
    if (key == 'night') return MapStyle.night;
    if (key == 'aubergine') return MapStyle.aubergine;
    return MapStyle.standard;
  }

  static String _convertValueToJson(final MapStyle value) {
    if (value == MapStyle.standard) return 'standard';
    if (value == MapStyle.silver) return 'silver';
    if (value == MapStyle.retro) return 'retro';
    if (value == MapStyle.dark) return 'dark';
    if (value == MapStyle.night) return 'night';
    if (value == MapStyle.aubergine) return 'aubergine';
    return 'standard';
  }

  static String _convertValueToDropDown(final MapStyle value) {
    if (value == MapStyle.standard) return 'Standard';
    if (value == MapStyle.silver) return 'Silver';
    if (value == MapStyle.retro) return 'Retro';
    if (value == MapStyle.dark) return 'Dark';
    if (value == MapStyle.night) return 'Night';
    if (value == MapStyle.aubergine) return 'Aubergine';
    return 'Standard';
  }

  static MapStyle _convertDropDownToValue(final String value) {
    if (value == 'Standard') return MapStyle.standard;
    if (value == 'Silver') return MapStyle.silver;
    if (value == 'Retro') return MapStyle.retro;
    if (value == 'Dark') return MapStyle.dark;
    if (value == 'Night') return MapStyle.night;
    if (value == 'Aubergine') return MapStyle.aubergine;
    return MapStyle.standard;
  }

  static String _convertValueToCode(final MapStyle? value) {
    if (value == MapStyle.standard) return 'Standard';
    if (value == MapStyle.silver) return 'Silver';
    if (value == MapStyle.retro) {
      return 'Retro';
    }
    if (value == MapStyle.dark) {
      return 'Dark';
    }
    if (value == MapStyle.night) {
      return 'Night';
    }
    if (value == MapStyle.aubergine) {
      return 'Aubergine';
    }
    return 'Standard';
  }

  /// Returns a code string from current value.
  /// e.g:
  /// ```dart
  /// 'MainAxisAlignment.start'
  /// ```
  String toCode() => _convertValueToCode(_style);
}
