// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
// Project imports:

class FATetaCMSInsert {
  static Future action(
    final BuildContext context,
    final String? collectionId,
    final Map<String, dynamic> map,
  ) async {
    final resp =
        await TetaCMS.instance.client.insertDocument(collectionId!, map);
  }

  static String toCode(
    final BuildContext context,
    final String? collectionId,
    final Map<String, dynamic> map,
  ) =>
      "final resp = await TetaCMS.instance.client.insertDocument('$collectionId', <String, dynamic>$map);";
}
