// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

/// [FBoxFit] is a set of functions to use [BoxFit] in widgets in Teta
class FBoxFit {
  /// Constructor
  FBoxFit({
    this.fit = BoxFit.cover,
  });

  /// The value in [BoxFit] of [FBoxFit]
  BoxFit fit;

  /// The list of optios for dropdown
  static List<String> get dropdownList => [
        'cover',
        'contain',
        'fill',
        'fitHeight',
        'fitWidth',
        'scaleDown',
      ];

  /// Get a [BoxFit] value
  /// Includes optionality checks
  BoxFit get get => fit;

  /// Convert [fit] to String value
  /// Includes optionality checks
  String get getString => _convertValueToDropDown(fit);

  /// Returns a css string value
  String get getCSS => _convertValueToCSS(fit);

  /// Instantiate a [FBoxFit] from Json
  static FBoxFit fromJson(String json) {
    try {
      return FBoxFit(
        fit: convertJsonToValue(json),
      );
    } catch (e) {
      return FBoxFit();
    }
  }

  /// Returns a Json from current object
  String toJson() => _convertValueToJson(fit);

  /// Clone [FBoxFit] (deep copy)
  FBoxFit clone() => FBoxFit(fit: fit);

  /// Clone [FBoxFit] (deep copy) with optional [fit] attribute
  FBoxFit copyWith({BoxFit? fit}) => FBoxFit(fit: fit ?? this.fit);

  static BoxFit convertDropdownToValue(String key) {
    switch (key) {
      case 'contain':
        return BoxFit.contain;
      case 'fill':
        return BoxFit.fill;
      case 'fitHeight':
        return BoxFit.fitHeight;
      case 'fitWidth':
        return BoxFit.fitWidth;
      case 'scaleDown':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  /// Convert a String value to [BoxFit] value
  /// ```dart
  /// if (key == 'cn') fit = BoxFit.contain;
  /// ```
  static BoxFit convertJsonToValue(String key) {
    switch (key) {
      case 'cn':
        return BoxFit.contain;
      case 'f':
        return BoxFit.fill;
      case 'fH':
        return BoxFit.fitHeight;
      case 'fW':
        return BoxFit.fitWidth;
      case 's':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static String _convertValueToJson(BoxFit value) {
    switch (value) {
      case BoxFit.contain:
        return 'cn';
      case BoxFit.fill:
        return 'f';
      case BoxFit.fitHeight:
        return 'fH';
      case BoxFit.fitWidth:
        return 'fW';
      case BoxFit.scaleDown:
        return 's';
      case BoxFit.cover:
        return 'cv';
      case BoxFit.none:
        return 'cv';
    }
  }

  static String _convertValueToDropDown(BoxFit value) {
    switch (value) {
      case BoxFit.contain:
        return 'contain';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.fitHeight:
        return 'fitHeight';
      case BoxFit.fitWidth:
        return 'fitWidth';
      case BoxFit.scaleDown:
        return 'scaleDown';
      case BoxFit.cover:
        return 'cover';
      case BoxFit.none:
        return 'cover';
    }
  }

  static String _convertValueToCSS(BoxFit value) {
    switch (value) {
      case BoxFit.cover:
        return 'cover';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.fitHeight:
        return 'contain';
      case BoxFit.fitWidth:
        return 'contain';
      case BoxFit.scaleDown:
        return 'scale-down';
      case BoxFit.none:
        return 'cover';
    }
  }

  static BoxFit convertCSSToValue(String? value) {
    switch (value) {
      case 'cover':
        return BoxFit.cover;
      case 'contain':
        return BoxFit.contain;
      case 'fill':
        return BoxFit.fill;
      case 'scale-down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static String _convertValueToCode(BoxFit value) {
    switch (value) {
      case BoxFit.contain:
        return 'BoxFit.contain';
      case BoxFit.fill:
        return 'BoxFit.fill';
      case BoxFit.fitHeight:
        return 'BoxFit.fitHeight';
      case BoxFit.fitWidth:
        return 'BoxFit.fitWidth';
      case BoxFit.scaleDown:
        return 'BoxFit.scaleDown';
      case BoxFit.cover:
        return 'BoxFit.cover';
      case BoxFit.none:
        return 'BoxFit.cover';
    }
  }

  /// Export code String
  /// ```dart
  /// if (type == BoxFit.cover) return 'BoxFit.cover'
  /// ```
  String toCode() => _convertValueToCode(fit);
}
