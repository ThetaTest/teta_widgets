// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/material.dart';

class FFontStyle extends Equatable {
  /// Set of funcs to use FontStyle in Teta
  FFontStyle({
    final FontStyle style = FontStyle.normal,
  }) : _style = style;

  FontStyle _style;

  @override
  List<Object?> get props => [_style];

  FontStyle get get => _style;

  // ignore: use_setters_to_change_properties
  void set(final FontStyle value) => _style = value;

  FFontStyle fromJson(final String json) {
    if (json == 'n') {
      return FFontStyle();
    } else {
      return FFontStyle(style: FontStyle.italic);
    }
  }

  String toJson() => (_style == FontStyle.normal) ? 'n' : 'i';

  static String _convertValueToJson(final FontStyle? style) =>
      (style == FontStyle.normal) ? 'FontStyle.normal' : 'FontStyle.italic';

  String toCode() => _convertValueToJson(_style);
}
