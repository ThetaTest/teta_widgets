// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

///Generates code for Responsive Condition widget
class ResponsiveConditionCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final mobileFlag = body.attributes[DBKeys.visibleOnMobile] as bool;
    final tabletFlag = body.attributes[DBKeys.visibleOnTablet] as bool;
    final childString = await CS.child(context, child, comma: true);
    final code = '''
     LayoutBuilder(builder: (context, constraints) {
       bool isMobileVisible = $mobileFlag;
       bool isTabletVisible = $tabletFlag;
       if(constraints.maxWidth < 600 && isMobileVisible){
         return SizedBox(
           $childString
         );
       }
       else if(constraints.maxWidth > 600 && isTabletVisible){
          return SizedBox(
           $childString
         );
       }
       else{
         return const SizedBox();
       }
    })
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {
    group('Responsive Condition toCode test', () {
      test(
        'Responsive Condition: default code',
        () {
          final body = NodeBody.get(NType.responsiveCondition);
          final mobileFlag = body.attributes[DBKeys.visibleOnMobile] as bool;
          final tabletFlag = body.attributes[DBKeys.visibleOnTablet] as bool;
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
           LayoutBuilder(builder: (context, constraints) {
               bool isMobileVisible = $mobileFlag;
               bool isTabletVisible = $tabletFlag;
               if(constraints.maxWidth < 600 && isMobileVisible){
                return SizedBox(
               $childString
                 );
               }
          else if(constraints.maxWidth > 600 && isTabletVisible){
          return SizedBox(
             $childString
              );
              }
               else{
                return const SizedBox();
              }
           })
            '''),
            true,
          );
        },
      );
    });
  }
}
