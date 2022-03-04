// Package imports:
// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

class FTextDirection {
  /// Set of funcs to use TextDirection within Teta
  FTextDirection({
    TextDirection dir = TextDirection.LTR,
  }) : _dir = dir;

  TextDirection _dir;

  TextDirection get get => _dir;

  String get getStringForDropDown => _convertValueToDropDown(_dir);

  void set(String value) => _dir = _convertDropDownToValue(value);

  static FTextDirection fromJson(String? json) {
    if (json != null) {
      return FTextDirection(
        dir: _convertJsonToValue(json),
      );
    } else {
      return FTextDirection();
    }
  }

  String toJson() => _convertValueToJson(_dir);

  static TextDirection _convertJsonToValue(String key) {
    if (key == 'r') return TextDirection.RTL;
    return TextDirection.LTR;
  }

  static TextDirection _convertDropDownToValue(String key) {
    if (key == 'Right to Left') return TextDirection.RTL;
    return TextDirection.LTR;
  }

  static String _convertValueToDropDown(TextDirection key) {
    if (key == TextDirection.RTL) return 'Right to Left';
    return 'Left to Right';
  }

  static String _convertValueToJson(TextDirection value) {
    if (value == TextDirection.RTL) return 'r';
    return 'l';
  }

  static String _convertValueToCode(TextDirection? value) {
    if (value == TextDirection.RTL) return 'TextDirection.RTL';
    return 'TextDirection.LTR';
  }

  String toCode() => _convertValueToCode(_dir);
}
