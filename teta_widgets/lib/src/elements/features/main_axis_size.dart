// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

///
class FMainAxisSize {
  /// Set of funcs for use [MainAxisSize] property in Teta
  FMainAxisSize({
    MainAxisSize align = MainAxisSize.max,
  }) : _align = align;

  MainAxisSize _align;

  MainAxisSize get get => _align;

  void set(String key) => _align = _convertJsonToValue(key);

  static FMainAxisSize fromJson(String? json) {
    if (json != null) {
      return FMainAxisSize(
        align: _convertJsonToValue(json),
      );
    } else {
      return FMainAxisSize();
    }
  }

  String toJson() => _convertValueToJson(_align);

  static MainAxisSize _convertJsonToValue(String key) {
    if (key == 'Min') {
      return MainAxisSize.min;
    } else {
      return MainAxisSize.max;
    }
  }

  static String _convertValueToJson(MainAxisSize value) {
    if (value == MainAxisSize.min) {
      return 'Min';
    } else {
      return 'Max';
    }
  }

  static String _convertValueToCode(MainAxisSize? value) {
    if (value == MainAxisSize.min) return 'MainAxisSize.min';
    return 'MainAxisSize.max';
  }

  /// Returns a code string from current value.
  /// e.g:
  /// ```dart
  /// 'MainAxisSize.max'
  /// ```
  String toCode() => _convertValueToCode(_align);
}
