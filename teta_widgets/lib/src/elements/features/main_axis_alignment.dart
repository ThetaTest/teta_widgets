// Flutter imports:
import 'package:flutter/material.dart';

///
class FMainAxisAlignment {
  /// Constructor
  FMainAxisAlignment({
    final MainAxisAlignment align = MainAxisAlignment.start,
  }) : _align = align;

  MainAxisAlignment _align;

  /// Returns current value
  MainAxisAlignment get get => _align;

  /// Returns a String value for DropDowns' value
  String get getString => _convertValueToDropDown(_align);

  /// Sets a new value for [_align]
  /// Requires a String value
  void set(final String text) => _align = _convertDropDownToValue(text);

  /// Instantiate [FMainAxisAlignment] from Json
  FMainAxisAlignment fromJson(final String json) {
    try {
      return FMainAxisAlignment(
        align: _convertJsonToValue(json),
      );
    } catch (e) {
      return this;
    }
  }

  /// Returns Json from actual value
  String toJson() {
    return _convertValueToJson(_align);
  }

  static MainAxisAlignment _convertJsonToValue(final String key) {
    if (key == 'e') return MainAxisAlignment.end;
    if (key == 'c') return MainAxisAlignment.center;
    if (key == 'sB') return MainAxisAlignment.spaceBetween;
    if (key == 'sA') return MainAxisAlignment.spaceAround;
    if (key == 'sE') return MainAxisAlignment.spaceEvenly;
    return MainAxisAlignment.start;
  }

  static String _convertValueToJson(final MainAxisAlignment value) {
    if (value == MainAxisAlignment.end) return 'e';
    if (value == MainAxisAlignment.center) return 'c';
    if (value == MainAxisAlignment.spaceBetween) return 'sB';
    if (value == MainAxisAlignment.spaceAround) return 'sA';
    if (value == MainAxisAlignment.spaceEvenly) return 'sE';
    return 's';
  }

  static String _convertValueToDropDown(final MainAxisAlignment value) {
    if (value == MainAxisAlignment.end) return 'End';
    if (value == MainAxisAlignment.center) return 'Center';
    if (value == MainAxisAlignment.spaceBetween) return 'Space Between';
    if (value == MainAxisAlignment.spaceAround) return 'Space Around';
    if (value == MainAxisAlignment.spaceEvenly) return 'Space Evenly';
    return 'Start';
  }

  static MainAxisAlignment _convertDropDownToValue(final String value) {
    if (value == 'End') return MainAxisAlignment.end;
    if (value == 'Center') return MainAxisAlignment.center;
    if (value == 'Space Between') return MainAxisAlignment.spaceBetween;
    if (value == 'Space Around') return MainAxisAlignment.spaceAround;
    if (value == 'Space Evenly') return MainAxisAlignment.spaceEvenly;
    return MainAxisAlignment.start;
  }

  static String _convertValueToCode(final MainAxisAlignment? value) {
    if (value == MainAxisAlignment.end) return 'MainAxisAlignment.end';
    if (value == MainAxisAlignment.center) return 'MainAxisAlignment.center';
    if (value == MainAxisAlignment.spaceBetween) {
      return 'MainAxisAlignment.spaceBetween';
    }
    if (value == MainAxisAlignment.spaceAround) {
      return 'MainAxisAlignment.spaceAround';
    }
    if (value == MainAxisAlignment.spaceEvenly) {
      return 'MainAxisAlignment.spaceEvenly';
    }
    return 'MainAxisAlignment.start';
  }

  /// Returns a code string from current value.
  /// e.g:
  /// ```dart
  /// 'MainAxisAlignment.start'
  /// ```
  String toCode() => _convertValueToCode(_align);
}
