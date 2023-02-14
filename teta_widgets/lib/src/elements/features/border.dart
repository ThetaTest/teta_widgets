// Flutter imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/design_system/hex_color.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/border_style.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';

/// Example
Widget toWidget() {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        left:
            BorderSide(width: 0, style: BorderStyle.none, color: Colors.green),
        top: BorderSide(width: 0, style: BorderStyle.none, color: Colors.green),
        right:
            BorderSide(width: 0, style: BorderStyle.none, color: Colors.green),
        bottom:
            BorderSide(width: 0, style: BorderStyle.none, color: Colors.green),
      ),
    ),
  );
}

/// [FBorder] is a set of functions to use [Border] in widgets in Teta
class FBorder extends Equatable {
  /// Constructor
  FBorder({
    this.fill,
    this.width,
    this.style,
  }) {
    fill ??= FFill();
    width ??= FMargins();
    style ??= FBorderStyle(
      style: BorderStyle.none,
    );
  }

  /// The [fill] of [Border]. It must be solid only
  FFill? fill;

  /// The [width] of [Border]
  FMargins? width;

  /// The [style] of [Border]
  FBorderStyle? style;

  @override
  List<Object?> get props => [fill, width, style];

  /// Get [Border] from actual values
  Border get(final BuildContext context, {required final bool forPlay}) {
    final values = width!.getList(context, forPlay: forPlay);
    final tempOpacity = fill?.levels?.first.opacity ?? 1;
    final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;
    return Border(
      left: BorderSide(
        color: HexColor(fill!.getHexColor(context)).withOpacity(opacity),
        style: style!.get,
        width: double.tryParse(values[0]) != null ? double.parse(values[0]) : 0,
      ),
      top: BorderSide(
        color: HexColor(fill!.getHexColor(context)).withOpacity(opacity),
        style: style!.get,
        width: double.tryParse(values[1]) != null ? double.parse(values[1]) : 0,
      ),
      right: BorderSide(
        color: HexColor(fill!.getHexColor(context)).withOpacity(opacity),
        style: style!.get,
        width: double.tryParse(values[2]) != null ? double.parse(values[2]) : 0,
      ),
      bottom: BorderSide(
        color: HexColor(fill!.getHexColor(context)).withOpacity(opacity),
        style: style!.get,
        width: double.tryParse(values[3]) != null ? double.parse(values[3]) : 0,
      ),
    );
  }

  /// Instantiate [FBorder] from Json
  static FBorder fromJson(final Map<String, dynamic> doc) {
    try {
      return FBorder(
        style: FBorderStyle.fromJson(doc[DBKeys.borderStyle] as String),
        width: FMargins.fromJson(doc[DBKeys.margins] as dynamic),
        fill: FFill().fromJson(doc[DBKeys.fill] as Map<String, dynamic>),
      );
    } catch (e) {
      return FBorder();
    }
  }

  /// Convert [FBorder] to Json
  Map<String, dynamic> toJson() => <String, dynamic>{
        DBKeys.borderStyle:
            style != null ? style!.toJson() : FBorderStyle().toJson(),
        DBKeys.margins: width != null ? width!.toJson() : FMargins().toJson(),
        DBKeys.fill: fill != null ? fill!.toJson() : FFill().toJson(),
      };

  /// Export code String
  String toCode(final BuildContext context) {
    String _valueToCode(final List<String> values) {
      final color = fill!.getHexColor(context);
      final tempOpacity = fill?.levels?.first.opacity ?? 1;
      final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;
      // if (style?.get != BorderStyle.none) return '';
      return '''
    Border(
      left:
          BorderSide(width: ${values[0] != '' ? values[0] : '0'}, ${style?.get != BorderStyle.solid ? 'style: ${style!.toCode()},' : ''} color: Color(0xFF$color).withOpacity($opacity)),
      top:
          BorderSide(width: ${values[1] != '' ? values[1] : '0'}, ${style?.get != BorderStyle.solid ? 'style: ${style!.toCode()},' : ''} color: Color(0xFF$color).withOpacity($opacity)),
      right:
          BorderSide(width: ${values[2] != '' ? values[2] : '0'}, ${style?.get != BorderStyle.solid ? 'style: ${style!.toCode()},' : ''} color: Color(0xFF$color).withOpacity($opacity)),
      bottom:
          BorderSide(width: ${values[3] != '' ? values[3] : '0'}, ${style?.get != BorderStyle.solid ? 'style: ${style!.toCode()},' : ''} color: Color(0xFF$color).withOpacity($opacity)),
    )
  ''';
    }

    if (width!.margins! == (width!.marginsTablet ?? width!.margins!) &&
        width!.margins! == (width!.marginsDesktop ?? width!.margins!)) {
      return _valueToCode(width!.margins!);
    }

    return '''
getValueForScreenType<Border>(
  context: context,
  mobile: ${_valueToCode(width!.margins!)},
  tablet: ${_valueToCode(width!.marginsTablet ?? width!.margins!)},
  desktop: ${_valueToCode(width!.marginsDesktop ?? width!.margins!)},
)
''';
  }
}
