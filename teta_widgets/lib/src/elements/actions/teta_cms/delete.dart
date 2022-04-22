// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
// Project imports:

class FATetaCMSDelete {
  static Future action(
    final BuildContext context,
    final String collectionId,
    final String documentId,
  ) async {
    final resp =
        await TetaCMS.instance.client.deleteDocument(collectionId, documentId);
  }

  static String toCode(
    final BuildContext context,
    final String collectionId,
    final String documentId,
  ) =>
      "final resp = await TetaCMS.instance.client.deleteDocument('$collectionId', '$documentId');";
}
