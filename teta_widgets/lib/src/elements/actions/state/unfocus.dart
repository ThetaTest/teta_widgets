// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
// Project imports:

class FActionStateUnfocus {
  static Future action(
    final BuildContext context,
  ) async {
    FocusScope.of(context).unfocus();
  }

  static String toCode(
  ) {
    return 'FocusScope.of(context).unfocus();';
  }
}
