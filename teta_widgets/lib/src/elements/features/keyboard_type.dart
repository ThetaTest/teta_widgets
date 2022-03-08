// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

class FKeyboardType {
  /// Set of funcs to use [TextInputType] in Teta
  FKeyboardType({
    final TextInputType type = TextInputType.text,
  }) : _type = type;

  /// Value of [FKeyboardType]
  TextInputType _type;

  /// Return value of [FKeyboardType]
  TextInputType get get => _type;

  /// Set new value to [_type]
  void set(final String value) {
    _type = _convertDropDownToValue(value);
  }

  /// Instantiate [FKeyboardType] from Json
  static FKeyboardType fromJson(final String json) {
    try {
      return FKeyboardType(
        type: _convertJsonToValue(json),
      );
    } catch (e) {
      return FKeyboardType();
    }
  }

  /// Returns Json based on current value
  String toJson() {
    return _convertValueToJson(_type);
  }

  static TextInputType _convertJsonToValue(final String key) {
    if (key == 't') return TextInputType.text;
    if (key == 'n') return TextInputType.name;
    if (key == 'e') return TextInputType.emailAddress;
    if (key == 'p') return TextInputType.phone;
    if (key == 'nm') return TextInputType.number;
    if (key == 'r') return TextInputType.url;
    if (key == 'v') return TextInputType.visiblePassword;
    if (key == 'm') return TextInputType.multiline;
    return TextInputType.text;
  }

  static TextInputType _convertDropDownToValue(final String key) {
    if (key == 'Text') {
      return TextInputType.text;
    } else if (key == 'Name') {
      return TextInputType.name;
    } else if (key == 'Email Address') {
      return TextInputType.emailAddress;
    } else if (key == 'Phone') {
      return TextInputType.phone;
    } else if (key == 'Number') {
      return TextInputType.number;
    } else if (key == 'Url') {
      return TextInputType.url;
    } else if (key == 'Visible Password') {
      return TextInputType.visiblePassword;
    } else if (key == 'Multiline') {
      return TextInputType.multiline;
    }
    return TextInputType.text;
  }

  static String _convertValueToJson(final TextInputType value) {
    if (value == TextInputType.text) {
      return 't';
    } else if (value == TextInputType.name) {
      return 'n';
    } else if (value == TextInputType.emailAddress) {
      return 'e';
    } else if (value == TextInputType.phone) {
      return 'p';
    } else if (value == TextInputType.number) {
      return 'nm';
    } else if (value == TextInputType.url) {
      return 'r';
    } else if (value == TextInputType.visiblePassword) {
      return 'v';
    } else if (value == TextInputType.multiline) {
      return 'm';
    }
    return 't';
  }

  static String _convertValueToCode(final TextInputType value) {
    if (value == TextInputType.text) {
      return 'TextInputType.text';
    } else if (value == TextInputType.name) {
      return 'TextInputType.name';
    } else if (value == TextInputType.emailAddress) {
      return 'TextInputType.emailAddress';
    } else if (value == TextInputType.phone) {
      return 'TextInputType.phone';
    } else if (value == TextInputType.number) {
      return 'TextInputType.number';
    } else if (value == TextInputType.url) {
      return 'TextInputType.url';
    } else if (value == TextInputType.visiblePassword) {
      return 'TextInputType.visiblePassword';
    } else if (value == TextInputType.multiline) {
      return 'TextInputType.multiline';
    }
    return 'TextInputType.text';
  }

  /// Returns code value
  /// e.g.
  /// ```dart
  /// "TextInputType.text"
  /// ```
  String toCode() => _convertValueToCode(_type);
}
