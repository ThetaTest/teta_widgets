// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

/// Stream connection is a class
/// to connect a single node to db
class StreamConnection {
  /// Listen to attributes' updates.
  ///
  /// Once a update is done, it calls mergeJson with new the map.
  /// It take from DB also the old version of map, which must be used
  /// for undo / redo system.
  static void connect(
    final int nodeId,
    final Function(Map<String, dynamic>) mergeJson,
    final BuildContext? context,
  ) {
    if (context == null) return;

    try {
      //debugPrint('connecting');
      /*NodeQueries.onAttributesByNode(
        nodeId,
        (map) {
          mergeJson(<String, dynamic>{map['name'] as String: map['value']});
        },
        (old) {},
      );*/
    } catch (e) {
      debugPrint('$e');
    }
  }
}
