// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/material.dart';

/// [FBorderStyle] is a set of functions to use [BorderStyle] in widgets in Teta
class FBorderStyle extends Equatable {
  /// Constructor
  FBorderStyle({
    this.style,
  }) {
    style ??= BorderStyle.solid;
  }

  /// Value of [FBorderStyle], optional [BorderStyle]
  BorderStyle? style;

  @override
  List<Object?> get props => [style];

  BorderStyle get get => style ?? BorderStyle.solid;

  /// Convert actual [style] to String
  String getString(final BuildContext context) {
    return _convertValueToDropDown(style!);
  }

  /// Instantiate [FBorderStyle] from Json
  static FBorderStyle fromJson(final String json) {
    try {
      return FBorderStyle(
        style: _convertJsonToValue(json),
      );
    } catch (e) {
      return FBorderStyle();
    }
  }

  /// Convert [FBorderStyle] to Json
  String toJson() {
    return _convertValueToJson(style!);
  }

  static BorderStyle _convertJsonToValue(final String key) {
    if (key == 'n') return BorderStyle.none;
    return BorderStyle.solid;
  }

  static String _convertValueToJson(final BorderStyle value) {
    if (value == BorderStyle.none) return 'n';
    return 's';
  }

  static String _convertValueToDropDown(final BorderStyle value) {
    if (value == BorderStyle.none) return 'None';
    return 'Solid';
  }

  static String _convertValueToCode(final BorderStyle? value) {
    if (value == BorderStyle.none) return 'BorderStyle.none';
    return 'BorderStyle.solid';
  }

  /// Convert [FBorderStyle] to code String
  String toCode() => _convertValueToCode(style);
}
