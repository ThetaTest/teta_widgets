// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String refreshIndicatorCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  List<CNode> children,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.duration] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final duration = int.tryParse(value) != null ? int.parse(value) : '1000';
  return '''
    RefreshIndicator(
      duration: const Duration(milliseconds: $duration),
      ${CS.action(context, node, ActionGesture.onTap, 'onPressed: () async', null, isRequired: false)}
      ${CS.size(context, body, isWidth: false)}
      ${CS.children(context, children)}
    )
  ''';
}
