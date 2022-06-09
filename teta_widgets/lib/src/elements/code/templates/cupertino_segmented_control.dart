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
  final int pageId,
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final List<CNode> children,
  final int loop,
) {
  StringBuffer map;
  if (children.isNotEmpty) {
    //here all the children are passed from tree view and setted
    map = StringBuffer()..write('{');
    for (var i = 0; i < children.length; i++) {
      map.write('$i: ${children[i].toCode(context)},');
    }
    map.write('},');
  } else {
    //here we use the default ones
    map = StringBuffer()
      ..write(
        '''
      {
        0: Container(
           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
           child: const Center(
              child: Text('Option 1'),
        ),
       ),
      ''',
      )
      ..write(
        '''
      1: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: const Center(
            child: Text('Option 2'),
        ),
       ),
      },
      ''',
      );
  }
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
      children: $map
      ${CS.action(
    pageId,
    context,
    node,
    ActionGesture.onTap,
    'onValueChanged: (value) async',
    'value',
    isRequired: true,
    loop: loop,
  )}
      $selectedColor
      $unselectedColor
      $pressedColor
      $borderColor
    )
  ''';
}
