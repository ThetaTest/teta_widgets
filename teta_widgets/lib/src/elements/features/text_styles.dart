// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:teta_core/src/design_system/hex_color.dart';
import 'package:teta_core/src/models/text_style.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/font_size.dart';
import 'package:teta_widgets/src/elements/features/font_style.dart';
import 'package:teta_widgets/src/elements/features/font_weight.dart';
import 'package:teta_widgets/src/elements/features/text_decoration.dart';

class TetaTextStyles {
  /// Returns the current TextStyle object
  static TextStyle get({
    required final BuildContext context,
    required final FFill fill,
    required final String fontFamily,
    required final FFontSize fontSize,
    required final FFontWeight fontWeight,
    required final FTextDecoration textDecoration,
    required final FFontStyle fontStyle,
    final TextStyleModel? model,
  }) {
    final tempOpacity = fill.levels?.first.opacity ?? 1;
    final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;
    return GoogleFonts.getFont(
      (model != null) ? model.fontFamily! : fontFamily,
      fontSize: (model != null) ? model.fontSize!.get() : fontSize.get(),
      fontWeight: (model != null) ? model.fontWeight!.get : fontWeight.get,
      color:
          HexColor(fill.get(context).getHexColor(context)).withOpacity(opacity),
      decoration: textDecoration.get,
      fontStyle: fontStyle.get,
    );
  }
}
