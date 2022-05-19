// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for ListView.builder widget
///
/// Returns:
/// ```dart
/// Builder(
///   builder: (context) {
///     final children = <Widget>[]; // node's children
///     return ListView.builder(
///       scrollDirection: Axis.vertical,
///       itemCount: children.length,
///       itemBuilder: (context, index) {
///         return children[index];
///       },
///     );
///   },
/// );
/// ```

class StripeCartItemsBuilderTemplate {
  static String toCode(final BuildContext context,
      final NodeBody body,
      final CNode? child,) {
    final _scrollDirection =
    !(body.attributes[DBKeys.isVertical] as bool? ?? false)
        ? 'scrollDirection: Axis.horizontal,'
        : '';
    final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;

    var childCode = 'const SizedBox();';
    if (child != null) {
      childCode = child.toCode(context);
    }
    return
    '''
      ListView.builder(
        $_scrollDirection
        shrinkWrap: $shrinkWrap,
        itemCount: (globalDatasets['cart'] as List? ?? []).length,
        itemBuilder: (context, index) {
          return $childCode;
        },
      )
    ''';
  }
}
