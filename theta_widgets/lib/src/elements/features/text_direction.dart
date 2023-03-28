// Package imports:
// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
// Package imports:

import 'package:flutter/material.dart';

class FTextDirection extends Equatable {
  /// Set of funcs to use TextDirection within Teta
  FTextDirection({
    final TextDirection dir = TextDirection.ltr,
  }) : _dir = dir;

  TextDirection _dir;

  @override
  List<Object?> get props => [_dir];

  TextDirection get get => _dir;

  String get getStringForDropDown => _convertValueToDropDown(_dir);

  void set(final String value) => _dir = _convertDropDownToValue(value);

  static FTextDirection fromJson(final String? json) {
    if (json != null) {
      return FTextDirection(
        dir: _convertJsonToValue(json),
      );
    } else {
      return FTextDirection();
    }
  }

  String toJson() => _convertValueToJson(_dir);

  static TextDirection _convertJsonToValue(final String key) {
    if (key == 'r') return TextDirection.rtl;
    return TextDirection.ltr;
  }

  static TextDirection _convertDropDownToValue(final String key) {
    if (key == 'Right to Left') return TextDirection.rtl;
    return TextDirection.ltr;
  }

  static String _convertValueToDropDown(final TextDirection key) {
    if (key == TextDirection.rtl) return 'Right to Left';
    return 'Left to Right';
  }

  static String _convertValueToJson(final TextDirection value) {
    if (value == TextDirection.rtl) return 'r';
    return 'l';
  }

  static String _convertValueToCode(final TextDirection? value) {
    if (value == TextDirection.rtl) return 'TextDirection.rtl';
    return 'TextDirection.ltr';
  }

  String toCode() => _convertValueToCode(_dir);
}
