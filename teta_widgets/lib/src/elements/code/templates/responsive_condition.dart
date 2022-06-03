// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Responsive Condition Template
String responsiveConditionCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode? child,
) {
  final mobileFlag = body.attributes[DBKeys.visibleOnMobile] as bool;
  final tabletFlag = body.attributes[DBKeys.visibleOnTablet] as bool;
  return '''
     LayoutBuilder(builder: (context, constraints) {
       bool isMobileVisible = $mobileFlag;
       bool isTabletVisible = $tabletFlag;
       if(constraints.maxWidth < 600 && isMobileVisible){
         return SizedBox(
           ${CS.child(context, child, comma: true)}
         );
       }
       else if(constraints.maxWidth > 600 && isTabletVisible){
          return SizedBox(
           ${CS.child(context, child, comma: true)}
         );
       }
       else{
         return const SizedBox();
       }
    })
  ''';
}
