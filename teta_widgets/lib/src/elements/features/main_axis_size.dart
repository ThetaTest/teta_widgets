// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/material.dart';

///
class FMainAxisSize extends Equatable {
  /// Set of funcs for use [MainAxisSize] property in Teta
  FMainAxisSize({
    final MainAxisSize align = MainAxisSize.max,
  }) : _align = align;

  MainAxisSize _align;

  @override
  List<Object?> get props => [_align];

  MainAxisSize get get => _align;

  /// Returns a String value for DropDowns' value
  String get getString => _convertValueToJson(_align);

  void set(final String key) => _align = _convertJsonToValue(key);

  static FMainAxisSize fromJson(final String? json) {
    if (json != null) {
      return FMainAxisSize(
        align: _convertJsonToValue(json),
      );
    } else {
      return FMainAxisSize();
    }
  }

  String toJson() => _convertValueToJson(_align);

  static MainAxisSize _convertJsonToValue(final String key) {
    if (key == 'Min') {
      return MainAxisSize.min;
    } else {
      return MainAxisSize.max;
    }
  }

  static String _convertValueToJson(final MainAxisSize value) {
    if (value == MainAxisSize.min) {
      return 'Min';
    } else {
      return 'Max';
    }
  }

  static String _convertValueToCode(final MainAxisSize? value) {
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
