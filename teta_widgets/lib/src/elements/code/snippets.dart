// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/align.dart';
import 'package:teta_widgets/src/elements/features/border.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/box_fit.dart';
import 'package:teta_widgets/src/elements/features/cross_axis_alignment.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/firestore_path.dart';
import 'package:teta_widgets/src/elements/features/main_axis_alignment.dart';
import 'package:teta_widgets/src/elements/features/main_axis_size.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/wrap_alignment.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Code Snippets. Set of funcs to generate properties' code string.
///
/// e.g. returns a string of width property:
/// ```dart
/// width: 50
/// ```
class CS {
  /// Returns a string "nameOfAttribute: value,"
  /// if [value] != [defaultValue].
  ///
  /// Returns a empty string if [value] == [defaultValue]
  static String avoidRedundantValue(
    dynamic value,
    String nameOfAttribute,
    String defaultValue,
  ) {
    return value != defaultValue ? '$nameOfAttribute: $value,' : '';
  }

  /// Returns eventualy child's code
  /// Returns a empty string if child is null
  ///
  /// e.g
  /// ```dart
  /// child: Center(),
  /// ```
  static String child(
    BuildContext context,
    CNode? child, {
    bool? comma,
  }) {
    var strChild = '';
    if (child != null) strChild = child.toCode(context);
    if (strChild.isEmpty) return '';
    return strChild != '' ? 'child: $strChild${comma ?? true ? ',' : ''}' : '';
  }

  /// Returns eventualy children' code
  /// Returns a empty string if children is empty
  ///
  /// e.g
  /// ```dart
  /// children: [
  ///   Center(),
  ///   Spacer(),
  /// ],
  /// ```
  static String children(BuildContext context, List<CNode> children) {
    final strChildren = StringBuffer()..write('');
    if (children.isNotEmpty) {
      for (final child in children) {
        if (child
            .toCode(context)
            .replaceAll(' ', '')
            .replaceAll(
              RegExp(r'\n'),
              '',
            )
            .isNotEmpty) {
          strChildren.write('${child.toCode(context)},');
        }
      }
      return '''
      children: [
        ${strChildren.toString()}
      ],''';
    } else {
      // children is empty
      // returns empty string
      return '';
    }
  }

  /// Returns eventualy children' code
  /// Returns a empty string if children is empty
  ///
  /// e.g
  /// ```dart
  /// Center(),
  /// Spacer(),
  /// ```
  static String flatChildren(BuildContext context, List<CNode> children) {
    final strChildren = StringBuffer()..write('');
    if (children.isNotEmpty) {
      for (final child in children) {
        strChildren.write(child.toCode(context));
      }
      return '${strChildren.toString()},';
    } else {
      // children is empty
      // returns empty string
      return '';
    }
  }

  /// Returns eventualy pages' code
  /// Returns a empty string if pages is empty
  ///
  /// e.g
  /// ```dart
  /// pages: [
  ///   Center(),
  ///   Spacer(),
  /// ],
  /// ```
  static String pages(BuildContext context, List<CNode> children) {
    final strChildren = StringBuffer()..write('');
    if (children.isNotEmpty) {
      for (final child in children) {
        if (child.toCode(context) != '') {
          strChildren.write('${child.toCode(context)},');
        }
      }
      return '''
      pages: [
        ${strChildren.toString()}
      ],''';
    } else {
      // children is empty
      // returns empty string
      return '';
    }
  }

  /// Returns eventualy width or height code.
  ///
  /// It returns a empty string if value != null or 'null'.
  ///
  /// e.g
  /// ```dart
  /// width: 250,
  /// ```
  ///
  /// or
  ///
  /// ```dart
  /// height: 52 * 13,
  /// ```
  static String size(
    BuildContext context,
    NodeBody body, {
    required bool isWidth,
  }) {
    final value =
        (body.attributes[isWidth ? DBKeys.width : DBKeys.height] as FSize)
            .toCode(context: context, isWidth: isWidth);
    return value != null && value != 'null'
        ? "${isWidth ? 'width' : 'height'}: $value,"
        : '';
  }

  /// Returns eventualy a FMargin code
  /// Requires [isMargin] to return margin: or padding:
  ///
  /// e.g.
  /// ```dart
  /// margin: EdgeInsets.only(
  ///   (eventualy): left: value,
  ///   (eventualy): top: value,
  ///   (eventualy): right: value,
  ///   (eventualy): bottom: value,
  /// )
  /// ```
  static String margin(
    BuildContext context,
    NodeBody body, {
    required bool isMargin,
  }) {
    final value = (body.attributes[isMargin ? DBKeys.margins : DBKeys.padding]
            as FMargins)
        .toCode(context);
    if (value == '') return '';
    return "${isMargin ? 'margin' : 'padding'}: $value,";
  }

  /// Returns BoxDecoration code
  ///
  /// ```dart
  /// decoration: BoxDecoration(
  ///   color: value,
  ///   borderRadius: see at [borderRadius] snippets
  /// )
  /// ```
  static String boxDecoration(
    BuildContext context,
    NodeBody body,
    String keyFill,
  ) {
    final flagConst = CS.borderRadius(context, body) != '';
    final fill =
        FFill.toCode(body.attributes[DBKeys.fill] as FFill, context, flagConst);
    final borderFill =
        (body.attributes[DBKeys.fill] as FFill).getHexColor(context);
    return '''
      decoration: ${flagConst ? '' : 'const'} BoxDecoration(
        ${fill ?? ''}
        ${CS.borderRadius(context, body)}
        ${CS.border(context, body)}
      ),
    ''';
  }

  /// Returns BorderRadius code
  ///
  /// ```dart
  /// BorderRadius.only(
  ///   topLeft: Radius.circular(value),
  ///   topRight: Radius.circular(value),
  ///   bottomRight: Radius.circular(value),
  ///   bottomLeft: Radius.circular(value),
  /// )
  /// ```
  static String borderRadius(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.borderRadius] != null
        ? (body.attributes[DBKeys.borderRadius] as FBorderRadius).toCode()
        : null;
    return avoidRedundantValue(value, 'borderRadius', '');
  }

  /// Returns BorderRadius code
  ///
  /// ```dart
  /// Border(
  ///   top: Radius.circular(value),
  ///   left: Radius.circular(value),
  ///   right: Radius.circular(value),
  ///   bottom: Radius.circular(value),
  /// )
  /// ```
  static String border(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.borders] != null
        ? (body.attributes[DBKeys.borders] as FBorder).toCode(context)
        : null;
    return avoidRedundantValue(value, 'border', '');
  }

  /// Returns BoxFit code
  ///
  /// ```dart
  /// BoxFit.cover
  /// ```
  static String boxFit(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.boxFit] != null
        ? (body.attributes[DBKeys.boxFit] as FBoxFit).toCode()
        : null;
    return avoidRedundantValue(value, 'fit', '');
  }

  /// Returns TextStyle and textAlign code
  ///
  /// ```dart
  /// style: TextStyle(
  ///   color: Colors.black,
  ///   fontWeight: FontWeight.normal,
  ///   fontSize: 16,
  ///   fontFamily: '',
  ///   fontStyle: FontStyle.normal,
  ///   decoration: TextDecoration.none,
  /// ),
  /// textAlign: TextAlign.center,
  /// ```
  static String textStyle(BuildContext context, NodeBody body, String key) {
    final value = body.attributes[key] != null
        ? (body.attributes[key] as FTextStyle).toCode(context)
        : null;
    return value ?? '';
  }

  /// Returns a gesture's code calling specificAction.toCode().
  ///
  /// It requires [gesture] to filter the type of gesture.
  /// It required the name of function with eventual parameters
  /// as following:
  ///
  /// func == onTap () or func == onHover (e)
  ///
  /// e.g.
  /// ```dart
  /// onTap: () {
  ///   ...generated code
  /// }
  /// ```
  static String action(
    BuildContext context,
    CNode node,
    ActionGesture gesture,
    String func,
    String? value, {
    required bool isRequired,
  }) {
    final code = StringBuffer()..write('');
    if (node.body.attributes[DBKeys.action] == null) return '';
    for (final element
        in (node.body.attributes[DBKeys.action] as FAction).actions!) {
      if (element.actionGesture == gesture) {
        code.write(element.toCode(value, context, node));
      }
    }
    return code.toString() == ''
        ? isRequired
            ? '$func { },'
            : ''
        : func == ''
            ? code.toString()
            : '''
    $func {
      ${code.toString()}
    },
    ''';
  }

  /// Returns alignment: Alignment code
  ///
  /// ```dart
  /// alignment: Alignment.topLeft
  /// ```
  ///
  /// It returns a empty screen in value is Alignment.center (redundant)
  static String align(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.align] != null
        ? (body.attributes[DBKeys.align] as FAlign).toCode()
        : null;
    return avoidRedundantValue(value, 'alignment', 'Alignment.center');
  }

  /// Returns mainAxisAlignment: MainAxisAlignment code
  ///
  /// ```dart
  /// mainAxisAlignment: MainAxisAlignment.spaceBetween
  /// ```
  ///
  /// It returns a empty screen in value is MainAxisAlignment.start (redundant)
  static String mainAxisAlignment(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.mainAxisAlignment] != null
        ? (body.attributes[DBKeys.mainAxisAlignment] as FMainAxisAlignment)
            .toCode()
        : null;
    return avoidRedundantValue(
      value,
      'mainAxisAlignment',
      'MainAxisAlignment.start',
    );
  }

  /// Returns mainAxisSize: MainAxisSize code
  ///
  /// ```dart
  /// mainAxisSize: MainAxisSize.min
  /// ```
  ///
  /// It returns a empty screen in value is MainAxisSize.max (redundant)
  static String mainAxisSize(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.mainAxisSize] != null
        ? (body.attributes[DBKeys.mainAxisSize] as FMainAxisSize).toCode()
        : null;
    return avoidRedundantValue(value, 'mainAxisSize', 'MainAxisSize.max');
  }

  /// Returns crossAxisAlignment: CrossAxisAlignment code
  ///
  /// ```dart
  /// crossAxisAlignment: CrossAxisAlignment.end
  /// ```
  ///
  /// It returns a empty screen in value
  /// is CrossAxisAlignment.center (redundant)
  static String crossAxisAlignment(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.crossAxisAlignment] != null
        ? (body.attributes[DBKeys.crossAxisAlignment] as FCrossAxisAlignment)
            .toCode()
        : null;
    return avoidRedundantValue(
      value,
      'crossAxisAlignment',
      'CrossAxisAlignment.center',
    );
  }

  /// Returns alignment: WrapAlignment code
  ///
  /// ```dart
  /// alignment: WrapAlignment.center
  /// ```
  ///
  /// It returns a empty screen in value is WrapAlignment.start (redundant)
  static String wrapAlignment(BuildContext context, NodeBody body) {
    final value = body.attributes[DBKeys.wrapAlignment] != null
        ? (body.attributes[DBKeys.wrapAlignment] as FWrapAlignment).toCode()
        : null;
    return avoidRedundantValue(value, 'wrapAlignment', 'WrapAlignment.start');
  }

  /// Returns Firestore path function.
  ///
  /// Requires the bool isStream to return a .get() or .snapshots() function
  ///
  /// Returns if path is even:
  /// ```dart
  /// FirebaseFirestore.instance.doc('').get()
  /// ```
  /// or
  /// ```dart
  /// FirebaseFirestore.instance.collection('').get()
  /// ```
  static String firestorePath(
    BuildContext context,
    NodeBody body, {
    required bool isStream,
  }) {
    final value = body.attributes[DBKeys.firestorePath] != null
        ? (body.attributes[DBKeys.firestorePath] as FFirestorePath)
            .toCode(context, isStream, null)
        : null;
    // FirebaseFirestore.instance.doc('').get()
    return value ?? '';
  }
}
