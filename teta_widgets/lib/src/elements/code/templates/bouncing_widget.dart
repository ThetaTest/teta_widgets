// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Bouncing widget
String bouncingWidgetCodeTemplate(
  final int pageId,
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final duration = int.tryParse(value) != null ? int.parse(value) : '200';
  final valueOfCondition =
      (body.attributes[DBKeys.valueOfCondition] as FTextTypeInput).toCode(loop);
  final scale = double.tryParse(valueOfCondition) ?? 1;
  final actionString = CS.action(
    pageId,
    context,
    node,
    ActionGesture.onTap,
    'onPressed: () async',
    null,
    isRequired: false,
    loop: loop,
  );
  return '''
    BouncingWidget(
      ${actionString != '' ? actionString : 'onPressed: () async {},'}
      duration: const Duration(milliseconds: $duration),
      scaleFactor: $scale,
      ${CS.child(context, child, comma: true)}
    )
  ''';
}
