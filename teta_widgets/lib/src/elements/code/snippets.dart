// Flutter imports:

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
import 'package:teta_widgets/src/elements/index.dart';
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
    final dynamic value,
    final String nameOfAttribute,
    final String defaultValue,
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
  static Future<String> child(
    final BuildContext context,
    final CNode? child, {
    final bool? comma,
    final bool withChild = true,
  }) async {
    var strChild = '';
    if (child != null) {
      strChild = await child.toCode(context);
    }
    if (!withChild) {
      return strChild != ''
          ? '$strChild${comma ?? true ? ',' : ''}'
          : 'const SizedBox(),';
    }
    return strChild != ''
        ? 'child: $strChild${comma ?? true ? ',' : ''}'
        : 'child: const SizedBox(),';
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
  static Future<String> children(
    final BuildContext context,
    final List<CNode> children, {
    final bool withComma = true,
  }) async {
    final strChildren = StringBuffer()..write('');
    if (children.isNotEmpty) {
      for (final child in children) {
        final childString = await child.toCode(context);
        if (childString
            .replaceAll(' ', '')
            .replaceAll(
              RegExp(r'\n'),
              '',
            )
            .isNotEmpty) {
          strChildren.write('$childString,');
        }
      }
      return '''
      children: [
        ${strChildren.toString()}
      ]${withComma ? ',' : ''}''';
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
  static String flatChildren(
    final BuildContext context,
    final List<CNode> children,
  ) {
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
  static String pages(final BuildContext context, final List<CNode> children) {
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
    final BuildContext context,
    final NodeBody body, {
    required final bool isWidth,
  }) {
    if (body.attributes[isWidth ? DBKeys.width : DBKeys.height] == null) {
      return '';
    }
    final value =
        (body.attributes[isWidth ? DBKeys.width : DBKeys.height] as FSize)
            .toCode(context: context, isWidth: isWidth);
    return value != null && value != 'null'
        ? "${isWidth ? 'width' : 'height'}: $value,"
        : '';
  }

  static Future<String> defaultWidgets(
    final BuildContext context,
    final CNode node,
    final int pageId,
    final Future<String> child,
    final int loop,
  ) async {
    return defaultWidgetVisibility(
      node,
      defaultWidgetResponsive(
        node,
        defaultWidgetMarginOrPadding(
          context,
          node,
          pageId,
          defaultWidgetGestureDetector(
            context,
            node,
            pageId,
            defaultWidgetTranslate(
              node.body,
              defaultWidgetRotate(
                node,
                defaultWidgetPerspective(
                  node.body,
                  defaultWidgetMarginOrPadding(
                    context,
                    node,
                    pageId,
                    defaultWidgetAnimation(node, child, loop),
                    loop,
                  ),
                  loop,
                ),
                loop,
              ),
              loop,
            ),
            loop,
          ),
          loop,
          isMargin: true,
        ),
        loop,
      ),
      loop,
    );
  }

  static Future<String> defaultWidgetGestureDetector(
    final BuildContext context,
    final CNode node,
    final int pageId,
    final Future<String> child,
    final int loop,
  ) async {
    final childString = await child;
    final originalType = NodeBody.get(node.globalType);
    if (originalType.attributes[DBKeys.action] == null) {
      return childString;
    }

    final onTap = CS.action(
      pageId,
      context,
      node,
      ActionGesture.onTap,
      'onTap: () async',
      null,
      isRequired: false,
      loop: loop,
    );
    final onDoubleTap = CS.action(
      pageId,
      context,
      node,
      ActionGesture.onDoubleTap,
      'onDoubleTap: () async',
      null,
      isRequired: false,
      loop: loop,
    );
    final onLongPress = CS.action(
      pageId,
      context,
      node,
      ActionGesture.onLongPress,
      'onLongPress: () async',
      null,
      isRequired: false,
      loop: loop,
    );
    if (onTap.isEmpty && onDoubleTap.isEmpty && onLongPress.isEmpty) {
      return childString;
    }

    return '''
    GestureDetector(
      $onTap
      $onDoubleTap
      $onLongPress
      child: $childString
    )''';
  }

  static Future<String> defaultWidgetMarginOrPadding(
    final BuildContext context,
    final CNode node,
    final int pageId,
    final Future<String> child,
    final int loop, {
    final bool isMargin = false,
    final bool withComma = false,
  }) async {
    Logger.printSuccess('defaultWidgetMarginOrPadding');
    final childString = await child;
    final originalType = NodeBody.get(node.globalType);
    Logger.printSuccess('Is margin: $isMargin');
    if (isMargin) {
      Logger.printSuccess('Is margin');
      if (originalType.attributes[DBKeys.margins] == null &&
          node.body.attributes[DBKeys.margins] != null) {
        final margin = CS.margin(context, node.body, isMargin: true);
        Logger.printSuccess('Is margin: $margin');
        if (margin == 'margin: EdgeInsets.zero,' || margin == '') {
          return childString;
        }

        return '''
    Padding(
      ${margin != '' ? margin.replaceFirst('margin', 'padding') : "padding: EdgeInsets.zero,"}
      child: $childString
    )${withComma ? ',' : ''}
  ''';
      }
      return childString;
    } else {
      if (originalType.attributes[DBKeys.padding] == null &&
          node.body.attributes[DBKeys.padding] != null) {
        final padding = CS.margin(context, node.body, isMargin: false);
        if (padding == 'padding: EdgeInsets.zero,' || padding == '') {
          return childString;
        }

        return '''
    Padding(
      ${padding != '' ? padding : "padding: EdgeInsets.zero,"}
      child: $childString
    )${withComma ? ',' : ''}
  ''';
      }
      return childString;
    }
  }

  static Future<String> defaultWidgetRotate(
    final CNode node,
    final Future<String> child,
    final int loop,
  ) async {
    final childString = await child;
    final abstract = node.body.attributes[DBKeys.rotation] as FTextTypeInput?;
    final rotation = abstract?.toCode(
          loop,
          resultType: ResultTypeEnum.int,
          defaultValue: '1',
        ) ??
        '1';

    final originalType = NodeBody.get(node.globalType);
    if (originalType.attributes[DBKeys.visibility] == null) {
      if (rotation != '1') {
        return '''
    RotatedBox(
      quarterTurns: $rotation,
      child: $childString
    )
  ''';
      }
    }
    return childString;
  }

  static Future<String> defaultWidgetTranslate(
    final NodeBody body,
    final Future<String> child,
    final int loop,
  ) async {
    /// Just an example
    void example() {
      Transform.translate(
        offset: const Offset(100, 0),
        child: Container(
          height: 100,
          width: 100,
          color: Colors.yellow,
        ),
      );
    }

    final childString = await child;
    final abstractX = body.attributes[DBKeys.xTranslation] as FTextTypeInput?;
    final transX = abstractX?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
          defaultValue: '0.0',
        ) ??
        '0.0';

    final abstractY = body.attributes[DBKeys.yTranslation] as FTextTypeInput?;
    final transY = abstractY?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
          defaultValue: '0.0',
        ) ??
        '0.0';

    if (transX == '0.0' && transY == '0.0') {
      return childString;
    }

    return '''
    Transform.translate(
      offset: const Offset($transX, $transY),
      child: $childString
    )
  ''';
  }

  static Future<String> defaultWidgetVisibility(
    final CNode node,
    final Future<String> child,
    final int loop,
  ) async {
    /// Just an example
    void example() {
      Visibility(
        visible: false,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.yellow,
        ),
      );
    }

    final childString = await child;
    final value = node.body.attributes[DBKeys.visibility] as bool? ?? true;

    final originalType = NodeBody.get(node.globalType);
    if (originalType.attributes[DBKeys.visibility] == null) {
      if (value == false) {
        return '''
    Visibility(
      visible: false,
      child: $childString
    )
  ''';
      }
    }
    return childString;
  }

  static Future<String> defaultWidgetAnimation(
    final CNode node,
    final Future<String> child,
    final int? loop,
  ) async {
    /// Just an example
    void example() {
      const AnimationConfiguration.staggeredList(
        position: 0,
        child: FadeInAnimation(
          child: ScaleAnimation(
            child: SlideAnimation(
              child: SizedBox(),
            ),
          ),
        ),
      );
    }

    String configCode(final String child) {
      if ((node.body.attributes[DBKeys.fadeAnimationEnabled] as bool? ??
              false) ||
          (node.body.attributes[DBKeys.scaleAnimationEnabled] as bool? ??
              false) ||
          (node.body.attributes[DBKeys.slideAnimationEnabled] as bool? ??
              false)) {
        return '''
        AnimationConfiguration.staggeredList(
          position: ${loop != null ? 'index' : '0'},
          child: $child
        )
      ''';
      } else {
        return child;
      }
    }

    String fadeCode(final String child) {
      if (node.body.attributes[DBKeys.fadeAnimationEnabled] as bool? ?? false) {
        return '''
        FadeInAnimation(
          child: $child
        ),
      ''';
      } else {
        return child;
      }
    }

    String scaleCode(final String child) {
      if (node.body.attributes[DBKeys.scaleAnimationEnabled] as bool? ??
          false) {
        return '''
        ScaleAnimation(
          child: $child
        ),
      ''';
      } else {
        return child;
      }
    }

    String slideCode(final String child) {
      if (node.body.attributes[DBKeys.slideAnimationEnabled] as bool? ??
          false) {
        return '''
        SlideAnimation(
          child: $child
        ),
      ''';
      } else {
        return child;
      }
    }

    final childString = await child;
    return configCode(fadeCode(scaleCode(slideCode(childString))));
  }

  static Future<String> defaultWidgetResponsive(
    final CNode node,
    final Future<String> child,
    final int loop,
  ) async {
    /// Just an example
    void example() {
      Builder(
        builder: (final context) {
          if (MediaQuery.of(context).size.shortestSide < 600) {
            // Mobile
            return const SizedBox();
          }
          if (MediaQuery.of(context).size.shortestSide < 1000) {
            // Tablet
            return const SizedBox();
          }
          // Desktop
          return const SizedBox();
        },
      );
    }

    final childString = await child;
    final visibleOnMobile =
        node.body.attributes[DBKeys.visibleOnMobile] as bool? ?? true;
    final visibleOnTablet =
        node.body.attributes[DBKeys.visibleOnTablet] as bool? ?? true;
    final visibleOnDesktop =
        node.body.attributes[DBKeys.visibleOnDesktop] as bool? ?? true;

    final originalType = NodeBody.get(node.globalType);
    if (originalType.attributes[DBKeys.visibleOnMobile] != null ||
        originalType.attributes[DBKeys.visibleOnTablet] != null ||
        originalType.attributes[DBKeys.visibleOnDesktop] != null) {
      return childString;
    }

    if (visibleOnMobile && visibleOnTablet && visibleOnDesktop) {
      return childString;
    }

    return '''
    Builder(
      builder: (final context) {
        if (MediaQuery.of(context).size.shortestSide <= 600) {
          // Mobile
          return Visibility(
            visible: $visibleOnMobile,
            child: $childString
          );
        }
        if (MediaQuery.of(context).size.shortestSide <= 1100) {
          // Tablet
          return Visibility(
            visible: $visibleOnTablet,
            child: $childString
          );
        }
        // Desktop
        return Visibility(
          visible: $visibleOnDesktop,
          child: $childString
        );
      },
    )
  ''';
  }

  static Future<String> defaultWidgetPerspective(
    final NodeBody body,
    final Future<String> child,
    final int loop,
  ) async {
    /// Just an example
    void example() {
      Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(0)
          ..rotateY(0),
        child: Container(
          height: 100,
          width: 100,
          color: Colors.yellow,
        ),
      );
    }

    final childString = await child;
    final abstractIdentityR =
        body.attributes[DBKeys.xPerspective] as FTextTypeInput?;
    final identityR = abstractIdentityR?.toCode(
          loop,
          resultType: ResultTypeEnum.int,
        ) ??
        '0';

    final abstractIdentityC =
        body.attributes[DBKeys.yPerspective] as FTextTypeInput?;
    final identityC = abstractIdentityC?.toCode(
          loop,
          resultType: ResultTypeEnum.int,
        ) ??
        '0';

    final abstractIdentityV =
        body.attributes[DBKeys.zPerspective] as FTextTypeInput?;
    final identityV = abstractIdentityV?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
          defaultValue: '0.0',
        ) ??
        '0.0';

    final abstractRotateX =
        body.attributes[DBKeys.xRotation] as FTextTypeInput?;
    final rotateX = abstractRotateX?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
          defaultValue: '0.0',
        ) ??
        '0.0';

    final abstractRotateY =
        body.attributes[DBKeys.yRotation] as FTextTypeInput?;
    final rotateY = abstractRotateY?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
          defaultValue: '0.0',
        ) ??
        '0.0';

    final abstractRotateZ =
        body.attributes[DBKeys.zRotation] as FTextTypeInput?;
    final rotateZ = abstractRotateZ?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
          defaultValue: '0.0',
        ) ??
        '0.0';

    final setIdentity = StringBuffer();
    if (identityC != '0' && identityV != '0' && identityR != '0.0') {
      setIdentity.write('..setEntry($identityR, $identityC, $identityV)');
    }

    final setRotationX = StringBuffer();
    if (rotateX != '0.0') {
      setRotationX.write('..rotateX($rotateX)');
    }

    final setRotationY = StringBuffer();
    if (rotateY != '0.0') {
      setRotationY.write('..rotateY($rotateY)');
    }

    final setRotationZ = StringBuffer();
    if (rotateZ != '0.0') {
      setRotationZ.write('..rotateZ($rotateZ)');
    }

    if (setIdentity.toString() == '' &&
        setRotationX.toString() == '' &&
        setRotationY.toString() == '' &&
        setRotationZ.toString() == '') {
      return childString;
    }

    return '''
    Transform(
      transform: Matrix4.identity()
        $setIdentity
        $setRotationX
        $setRotationY
        $setRotationZ,
      child: $childString
    )
  ''';
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
    final BuildContext context,
    final NodeBody body, {
    required final bool isMargin,
  }) {
    final value = (body.attributes[isMargin ? DBKeys.margins : DBKeys.padding]
                as FMargins?)
            ?.toCode(context) ??
        '';
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
    final BuildContext context,
    final NodeBody body,
    final String keyFill,
  ) {
    final fill = FFill.toCode(
      body.attributes[keyFill] as FFill,
      context,
      flagConst: false,
    );

    return '''
      decoration: BoxDecoration(
        ${fill ?? ''}
        ${CS.borderRadius(context, body)}
        ${CS.border(context, body)}
      ),
    ''';
  }

  ///shape for card
  static String shapeCardBorderRadius(
    final BuildContext context,
    final NodeBody body,
  ) {
    return '''
      shape: RoundedRectangleBorder(
        ${CS.borderRadius(context, body)}
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
  static String borderRadius(final BuildContext context, final NodeBody body) {
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
  static String border(final BuildContext context, final NodeBody body) {
    final value = body.attributes[DBKeys.borders] != null
        ? (body.attributes[DBKeys.borders] as FBorder).toCode(context)
        : null;
    // if (value != null && value != '') return '';
    return avoidRedundantValue(value, 'border', '');
  }

  /// Returns BoxFit code
  ///
  /// ```dart
  /// BoxFit.cover
  /// ```
  static String boxFit(final BuildContext context, final NodeBody body) {
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
  static String textStyle(
    final BuildContext context,
    final NodeBody body,
    final String key,
  ) {
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
    final int pageId,
    final BuildContext context,
    final CNode node,
    final ActionGesture gesture,
    final String func,
    final String? value, {
    required final int? loop,
    required final bool isRequired,
    final String? additionalCode,
    final bool withValue = false,
    final bool endsWithComma = true,
  }) {
    final code = StringBuffer()..write('');
    if (node.body.attributes[DBKeys.action] == null) return '';
    for (final element
        in (node.body.attributes[DBKeys.action] as FAction).actions!) {
      if (element.actionGesture == gesture) {
        code.write(
          element.toCode(
            pageId: pageId,
            value: value,
            context: context,
            body: node,
            loop: loop ?? 0,
            withValue: withValue,
          ),
        );
      }
    }
    if (code.toString().isEmpty && additionalCode == null && !isRequired) {
      return '';
    }
    return '''
    $func {
      ${additionalCode ?? ''}
      ${code.toString()}
    }${endsWithComma ? ',' : ''}
    ''';
  }

  static String getActionsInFormOfFutureDelayed(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final ActionGesture gesture,
    final String? value, {
    required final int? loop,
    final String? additionalCode,
    final bool withValue = false,
    final bool endsWithComma = true,
  }) {
    final code = StringBuffer()..write('');
    if (node.body.attributes[DBKeys.action] == null) return '';
    for (final element
        in (node.body.attributes[DBKeys.action] as FAction).actions!) {
      if (element.actionGesture == gesture) {
        code.write(
          element.toCode(
            pageId: pageId,
            value: value,
            context: context,
            body: node,
            loop: loop ?? 0,
            withValue: withValue,
          ),
        );
      }
    }
    return '''
    unawaited(
      Future.delayed(
        Duration.zero,
        () async {
          ${code.toString()}
        },
      ),
    );
    ''';
  }

  /// Returns alignment: Alignment code
  ///
  /// ```dart
  /// alignment: Alignment.topLeft
  /// ```
  ///
  /// It returns a empty screen in value is Alignment.center (redundant)
  static String align(final NodeBody body) {
    final value = body.attributes[DBKeys.align] != null
        ? (body.attributes[DBKeys.align] as FAlign).toCode()
        : null;
    return value != null
        ? avoidRedundantValue(value, 'alignment', 'Alignment.center')
        : '';
  }

  /// Returns ScrollPhysics for ListView
  ///
  /// ```dart
  /// physics: const AlwaysScrollableScrollPhysics()
  ///          const NeverScrollableScrollPhysics()
  ///          const BouncingScrollPhysics()
  /// ```
  ///
  static String physic(final BuildContext context, final NodeBody body) {
    final value = body.attributes[DBKeys.physic] != null
        ? (body.attributes[DBKeys.physic] as FPhysic).toCode()
        : null;
    return value!;
  }

  /// Returns mainAxisAlignment: MainAxisAlignment code
  ///
  /// ```dart
  /// mainAxisAlignment: MainAxisAlignment.spaceBetween
  /// ```
  ///
  /// It returns a empty screen in value is MainAxisAlignment.start (redundant)
  static String mainAxisAlignment(
    final BuildContext context,
    final NodeBody body,
  ) {
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
  static String mainAxisSize(final BuildContext context, final NodeBody body) {
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
  static String crossAxisAlignment(
    final BuildContext context,
    final NodeBody body,
  ) {
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
  static String wrapAlignment(final BuildContext context, final NodeBody body) {
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
    final BuildContext context,
    final NodeBody body, {
    required final bool isStream,
  }) {
    final value = body.attributes[DBKeys.firestorePath] != null
        ? (body.attributes[DBKeys.firestorePath] as FFirestorePath).toCode(
            context,
            null,
            isStream: isStream,
          )
        : null;
    // FirebaseFirestore.instance.doc('').get()
    return value ?? '';
  }
}
