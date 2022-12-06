// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/teta_widget_state.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Builder
class GestureBuilderBase {
  /// Get a gesture code based on FAction
  static Widget get({
    required final BuildContext context,
    required final TetaWidgetState state,
    required final Widget child,
  }) =>
      ResponsiveVisibilityBase.get(
        context: context,
        node: state.node,
        child: VisibilityBase.get(
          node: state.node,
          child: MarginOrPaddingBase.get(
            context: context,
            node: state.node,
            params: state.params,
            states: state.states,
            dataset: state.dataset,
            forPlay: state.forPlay,
            loop: state.loop,
            child: GestureBuilderBase.getGesture(
              context: context,
              state: state,
              child: TranslateBase.get(
                context: context,
                node: state.node,
                params: state.params,
                states: state.states,
                dataset: state.dataset,
                forPlay: state.forPlay,
                loop: state.loop,
                child: RotationBase.get(
                  context: context,
                  node: state.node,
                  params: state.params,
                  states: state.states,
                  dataset: state.dataset,
                  forPlay: state.forPlay,
                  loop: state.loop,
                  child: PerspectiveBase.get(
                    context: context,
                    node: state.node,
                    params: state.params,
                    states: state.states,
                    dataset: state.dataset,
                    forPlay: state.forPlay,
                    loop: state.loop,
                    child: MarginOrPaddingBase.get(
                      context: context,
                      node: state.node,
                      params: state.params,
                      states: state.states,
                      dataset: state.dataset,
                      forPlay: state.forPlay,
                      loop: state.loop,
                      child: EntryAnimationsBase().get(
                        node: state.node,
                        child: child,
                        loop: state.loop,
                      ),
                      isMargins: false,
                    ),
                  ),
                ),
              ),
            ),
            isMargins: true,
          ),
        ),
      );

  static Widget getGesture({
    required final BuildContext context,
    required final TetaWidgetState state,
    required final Widget child,
  }) {
    if (state.node.body.attributes[DBKeys.action] != null) {
      final originalType = NodeBody.get(state.node.globalType);
      if (originalType.attributes[DBKeys.action] == null) {
        return GestureDetector(
          onTap: () {
            GestureBuilder.get(
              context: context,
              state: state,
              gesture: ActionGesture.onTap,
              action: state.node.body.attributes[DBKeys.action] as FAction,
              actionValue: null,
            );
          },
          onDoubleTap: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onDoubleTap,
            action: state.node.body.attributes[DBKeys.action] as FAction,
            actionValue: null,
          ),
          onLongPress: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onLongPress,
            action: state.node.body.attributes[DBKeys.action] as FAction,
            actionValue: null,
          ),
          child: child,
        );
      }
    }
    return child;
  }
}

class MarginOrPaddingBase {
  /// Get a gesture code based on FAction
  static Widget get({
    required final BuildContext context,
    required final CNode node,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final Widget child,
    required final bool isMargins,
    final int? loop,
  }) {
    if (isMargins) {
      if (node.body.attributes[DBKeys.margins] != null) {
        final originalType = NodeBody.get(node.globalType);
        if (originalType.attributes[DBKeys.margins] == null) {
          return Padding(
            padding:
                (node.body.attributes[DBKeys.margins] as FMargins).get(context),
            child: child,
          );
        }
      }
    } else {
      if (node.body.attributes[DBKeys.padding] != null) {
        final originalType = NodeBody.get(node.globalType);
        if (originalType.attributes[DBKeys.padding] == null) {
          return Padding(
            padding:
                (node.body.attributes[DBKeys.padding] as FMargins).get(context),
            child: child,
          );
        }
      }
    }
    return child;
  }
}

class TranslateBase {
  /// Get a gesture code based on FAction
  static Widget get({
    required final BuildContext context,
    required final CNode node,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final Widget child,
    final int? loop,
  }) {
    final abstractX =
        node.body.attributes[DBKeys.xTranslation] as FTextTypeInput?;
    final valueX =
        abstractX?.get(params, states, dataset, forPlay, loop, context) ?? '0';
    final transX = double.tryParse(valueX) != null ? double.parse(valueX) : 0.0;

    final abstractY =
        node.body.attributes[DBKeys.yTranslation] as FTextTypeInput?;
    final valueY =
        abstractY?.get(params, states, dataset, forPlay, loop, context) ?? '0';
    final transY = double.tryParse(valueY) != null ? double.parse(valueY) : 0.0;

    if (transX != 0 || transY != 0) {
      return Transform.translate(
        offset: Offset(transX, transY),
        child: child,
      );
    }
    return child;
  }
}

class RotationBase {
  /// Get a gesture code based on FAction
  static Widget get({
    required final BuildContext context,
    required final CNode node,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final Widget child,
    final int? loop,
  }) {
    final abstract = node.body.attributes[DBKeys.rotation] as FTextTypeInput?;
    final value =
        abstract?.get(params, states, dataset, forPlay, loop, context) ?? '1';
    final rotation = int.tryParse(value) != null ? int.parse(value) : 1;

    final originalType = NodeBody.get(node.globalType);
    if (originalType.attributes[DBKeys.rotation] == null) {
      if (rotation != 1) {
        return RotatedBox(
          quarterTurns: rotation,
          child: child,
        );
      }
    }
    return child;
  }
}

class PerspectiveBase {
  /// Get a gesture code based on FAction
  static Widget get({
    required final BuildContext context,
    required final CNode node,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final Widget child,
    final int? loop,
  }) {
    final abstractIdentityR =
        node.body.attributes[DBKeys.xPerspective] as FTextTypeInput?;
    final valueIdentityR = abstractIdentityR?.toCode(
          loop,
          resultType: ResultTypeEnum.int,
        ) ??
        '0';
    final identityR =
        int.tryParse(valueIdentityR) != null ? int.parse(valueIdentityR) : 0;

    final abstractIdentityC =
        node.body.attributes[DBKeys.yPerspective] as FTextTypeInput?;
    final valueIdentityC = abstractIdentityC?.toCode(
          loop,
          resultType: ResultTypeEnum.int,
        ) ??
        '0';
    final identityC =
        int.tryParse(valueIdentityC) != null ? int.parse(valueIdentityC) : 0;

    final abstractIdentityV =
        node.body.attributes[DBKeys.zPerspective] as FTextTypeInput?;
    final valueIdentityV = abstractIdentityV?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
        ) ??
        '0.0';
    final identityV = double.tryParse(valueIdentityV) != null
        ? double.parse(valueIdentityV)
        : 0.0;

    final abstractRotateX =
        node.body.attributes[DBKeys.xRotation] as FTextTypeInput?;
    final valueRotateX = abstractRotateX?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
        ) ??
        '0.0';
    final rotateX = double.tryParse(valueRotateX) != null
        ? double.parse(valueRotateX)
        : 0.0;

    final abstractRotateY =
        node.body.attributes[DBKeys.yRotation] as FTextTypeInput?;
    final valueRotateY = abstractRotateY?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
        ) ??
        '0.0';
    final rotateY = double.tryParse(valueRotateY) != null
        ? double.parse(valueRotateY)
        : 0.0;

    final abstractRotateZ =
        node.body.attributes[DBKeys.zRotation] as FTextTypeInput?;
    final valueRotateZ = abstractRotateZ?.toCode(
          loop,
          resultType: ResultTypeEnum.double,
        ) ??
        '0.0';
    final rotateZ = double.tryParse(valueRotateZ) != null
        ? double.parse(valueRotateZ)
        : 0.0;

    final matrix = Matrix4.identity();
    if (identityC != 0 && identityV != 0 && identityR != 0) {
      matrix.setEntry(identityR, identityC, identityV.toDouble());
    }

    if (rotateX != 0) {
      matrix.rotateX(rotateX.toDouble());
    }

    if (rotateY != 0) {
      matrix.rotateY(rotateY.toDouble());
    }

    if (rotateZ != 0) {
      matrix.rotateZ(rotateZ.toDouble());
    }

    return Transform(
      transform: matrix,
      child: child,
    );
  }
}

class EntryAnimationsBase {
  Widget fade(
    final CNode node,
    final Widget child,
  ) {
    if (node.body.attributes[DBKeys.fadeAnimationEnabled] as bool? ?? false) {
      return FadeInAnimation(child: child);
    }
    return child;
  }

  Widget scale(
    final CNode node,
    final Widget child,
  ) {
    if (node.body.attributes[DBKeys.scaleAnimationEnabled] as bool? ?? false) {
      return ScaleAnimation(child: child);
    }
    return child;
  }

  Widget slide(
    final CNode node,
    final Widget child,
  ) {
    if (node.body.attributes[DBKeys.slideAnimationEnabled] as bool? ?? false) {
      return SlideAnimation(child: child);
    }
    return child;
  }

  Widget get({
    required final CNode node,
    required final Widget child,
    required final int? loop,
  }) {
    if ((node.body.attributes[DBKeys.fadeAnimationEnabled] as bool? ?? false) &&
        (node.body.attributes[DBKeys.scaleAnimationEnabled] as bool? ??
            false) &&
        (node.body.attributes[DBKeys.slideAnimationEnabled] as bool? ??
            false)) {
      return AnimationConfiguration.staggeredList(
        position: loop ?? 0,
        child: fade(
          node,
          scale(
            node,
            slide(
              node,
              child,
            ),
          ),
        ),
      );
    }
    return child;
  }
}

class VisibilityBase {
  /// Get a gesture code based on FAction
  static Widget get({
    required final CNode node,
    required final Widget child,
  }) {
    final value = node.body.attributes[DBKeys.visibility] as bool? ?? true;

    final originalType = NodeBody.get(node.globalType);
    if (originalType.attributes[DBKeys.visibility] == null) {
      if (!value) {
        return Visibility(
          visible: false,
          child: child,
        );
      }
    }
    return child;
  }
}

class ResponsiveVisibilityBase {
  static Widget get({
    required final BuildContext context,
    required final CNode node,
    required final Widget child,
  }) {
    final visibleOnMobile =
        node.body.attributes[DBKeys.visibleOnMobile] as bool? ?? true;
    final visibleOnTablet =
        node.body.attributes[DBKeys.visibleOnTablet] as bool? ?? true;
    final visibleOnDesktop =
        node.body.attributes[DBKeys.visibleOnDesktop] as bool? ?? true;

    final originalType = NodeBody.get(node.globalType);
    if (originalType.attributes[DBKeys.visibleOnMobile] == null &&
        originalType.attributes[DBKeys.visibleOnTablet] == null &&
        originalType.attributes[DBKeys.visibleOnDesktop] == null) {
      return Builder(
        builder: (final context) {
          if (MediaQuery.of(context).size.shortestSide <= 600) {
            return Visibility(
              visible: visibleOnMobile,
              child: child,
            );
          }
          if (MediaQuery.of(context).size.shortestSide <= 1100) {
            return Visibility(
              visible: visibleOnTablet,
              child: child,
            );
          }
          return Visibility(
            visible: visibleOnDesktop,
            child: child,
          );
        },
      );
    }
    return child;
  }
}
