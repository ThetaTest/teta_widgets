// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for RevenueCat product list widget, unclassified for now
String revenueCatProductsListCodeTemplate(
  BuildContext context,
  NodeBody body,
  List<CNode> children,
  int? loop,
) {
  var child = 'const SizedBox()';
  if (children.isNotEmpty) {
    child = children.first.toCode(context);
  }
  var loader = 'const CircularProgressIndicator()';
  if (children.length >= 2) {
    loader = children[1].toCode(context);
  }

  return '''
  FutureBuilder(
    future: Purchases.getOfferings(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      else{
        return $child;
      }
    }
  )
  ''';
}
