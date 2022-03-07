// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino Segmented Control Template
String cupertinoSegmentedControlCodeTemplate(
  BuildContext context,
  NodeBody body,
  CNode node,
  List<CNode> children,
) {
  final map = StringBuffer()..write('{');
  for (var i = 0; i < children.length; i++) {
    map.write('$i: ${children[i].toCode(context)}');
  }
  map.write('}');
  final selectedColor = FFill.toCode(
    body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: true,
  )?.replaceFirst('color:', 'selectedColor:');
  final unselectedColor = FFill.toCode(
    body.attributes[DBKeys.bgFill] as FFill,
    context,
    flagConst: true,
  )?.replaceFirst('color:', 'unselectedColor:');
  final pressedColor = FFill.toCode(
    body.attributes[DBKeys.textFill] as FFill,
    context,
    flagConst: true,
  )?.replaceFirst('color:', 'pressedColor:');
  final borderColor = FFill.toCode(
    body.attributes[DBKeys.activeFill] as FFill,
    context,
    flagConst: true,
  )?.replaceFirst('color:', 'borderColor:');
  return '''
    CupertinoSegmentedControl<int>(
      children: map,
      ${CS.action(context, node, ActionGesture.onTap, 'onValueChanged: (value) async', 'value', isRequired: true)}
      $selectedColor
      $unselectedColor
      $pressedColor
      $borderColor
    )
  ''';
}
