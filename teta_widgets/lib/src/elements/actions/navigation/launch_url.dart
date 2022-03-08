// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:url_launcher/url_launcher.dart';

class FActionNavigationLaunchURL {
  static Future action(final BuildContext context, final String? value) async {
    if (value != null) {
      if (await canLaunch(value)) await launch(value, forceWebView: true);
    }
  }

  static String toCode(final String? value) {
    if (value == null) return '';
    return """
    if ('''$value''' != null) {
      if (await canLaunch('''$value''')) await launch('''$value''', forceWebView: true);
    }
    """;
  }
}
