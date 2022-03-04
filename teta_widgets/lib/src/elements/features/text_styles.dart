// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:google_fonts/google_fonts.dart';
// Project imports:
import 'package:teta_core/src/design_system/hex_color.dart';
import 'package:teta_core/src/models/text_style.dart';
import 'package:teta_elements/src/elements/features/fill.dart';
import 'package:teta_elements/src/elements/features/font_size.dart';
import 'package:teta_elements/src/elements/features/font_style.dart';
import 'package:teta_elements/src/elements/features/font_weight.dart';
import 'package:teta_elements/src/elements/features/text_decoration.dart';

class TetaTextStyles {
  /// Returns the current TextStyle object
  static TextStyle get({
    required BuildContext context,
    required FFill fill,
    TextStyleModel? model,
    required String fontFamily,
    required FFontSize fontSize,
    required FFontWeight fontWeight,
    required FTextDecoration textDecoration,
    required FFontStyle fontStyle,
  }) {
    return GoogleFonts.getFont(
      (model != null) ? model.fontFamily! : fontFamily,
      fontSize: (model != null) ? model.fontSize!.get : fontSize.get,
      fontWeight: (model != null) ? model.fontWeight!.get : fontWeight.get,
      color: HexColor(fill.get(context).getHexColor(context)),
      decoration: textDecoration.get,
      fontStyle: fontStyle.get,
    );
  }
}
