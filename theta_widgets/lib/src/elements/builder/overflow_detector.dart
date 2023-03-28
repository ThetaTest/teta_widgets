// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class OverflowIndicator extends StatelessWidget {
  const OverflowIndicator({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _OverflowIndicator(
      child: child,
      constraintsTransform: (e) {
        return e;
      },
    );
  }
}

class _OverflowIndicator extends SingleChildRenderObjectWidget {
  /// Creates a widget that uses a function to transform the constraints it
  /// passes to its child. If the child overflows the parent's constraints, a
  /// warning will be given in debug mode.
  ///
  /// The `debugTransformType` argument adds a debug label to this widget.
  ///
  /// The `alignment`, `clipBehavior` and `constraintsTransform` arguments must
  /// not be null.
  const _OverflowIndicator({
    super.key,
    super.child,
    this.textDirection,
    this.alignment = Alignment.center,
    required this.constraintsTransform,
    this.clipBehavior = Clip.none,
    String debugTransformType = '',
  }) : _debugTransformLabel = debugTransformType;

  /// A [BoxConstraintsTransform] that always returns its argument as-is (i.e.,
  /// it is an identity function).
  ///
  /// The [ConstraintsTransformBox] becomes a proxy widget that has no effect on
  /// layout if [constraintsTransform] is set to this.
  static BoxConstraints unmodified(BoxConstraints constraints) => constraints;

  /// A [BoxConstraintsTransform] that always returns a [BoxConstraints] that
  /// imposes no constraints on either dimension (i.e. `const BoxConstraints()`).
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" size (equivalent to an [UnconstrainedBox] with `constrainedAxis`
  /// set to null).
  static BoxConstraints unconstrained(BoxConstraints constraints) =>
      const BoxConstraints();

  /// A [BoxConstraintsTransform] that removes the width constraints from the
  /// input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" width (equivalent to an [UnconstrainedBox] with
  /// `constrainedAxis` set to [Axis.horizontal]).
  static BoxConstraints widthUnconstrained(BoxConstraints constraints) =>
      constraints.heightConstraints();

  /// A [BoxConstraintsTransform] that removes the height constraints from the
  /// input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" height (equivalent to an [UnconstrainedBox] with
  /// `constrainedAxis` set to [Axis.vertical]).
  static BoxConstraints heightUnconstrained(BoxConstraints constraints) =>
      constraints.widthConstraints();

  /// A [BoxConstraintsTransform] that removes the `maxHeight` constraint from
  /// the input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" height or the `minHeight` of the incoming [BoxConstraints],
  /// whichever is larger.
  static BoxConstraints maxHeightUnconstrained(BoxConstraints constraints) =>
      constraints.copyWith(maxHeight: double.infinity);

  /// A [BoxConstraintsTransform] that removes the `maxWidth` constraint from
  /// the input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at its
  /// "natural" width or the `minWidth` of the incoming [BoxConstraints],
  /// whichever is larger.
  static BoxConstraints maxWidthUnconstrained(BoxConstraints constraints) =>
      constraints.copyWith(maxWidth: double.infinity);

  /// A [BoxConstraintsTransform] that removes both the `maxWidth` and the
  /// `maxHeight` constraints from the input.
  ///
  /// Setting [constraintsTransform] to this allows [child] to render at least
  /// its "natural" size, and grow along an axis if the incoming
  /// [BoxConstraints] has a larger minimum constraint on that axis.
  static BoxConstraints maxUnconstrained(BoxConstraints constraints) =>
      constraints.copyWith(
          maxWidth: double.infinity, maxHeight: double.infinity);

  static final Map<BoxConstraintsTransform, String> _debugKnownTransforms =
      <BoxConstraintsTransform, String>{
    unmodified: 'unmodified',
    unconstrained: 'unconstrained',
    widthUnconstrained: 'width constraints removed',
    heightUnconstrained: 'height constraints removed',
    maxWidthUnconstrained: 'maxWidth constraint removed',
    maxHeightUnconstrained: 'maxHeight constraint removed',
    maxUnconstrained: 'maxWidth & maxHeight constraints removed',
  };

  /// The text direction to use when interpreting the [alignment] if it is an
  /// [AlignmentDirectional].
  ///
  /// Defaults to null, in which case [Directionality.maybeOf] is used to determine
  /// the text direction.
  final TextDirection? textDirection;

  /// The alignment to use when laying out the child, if it has a different size
  /// than this widget.
  ///
  /// If this is an [AlignmentDirectional], then [textDirection] must not be
  /// null.
  ///
  /// See also:
  ///
  ///  * [Alignment] for non-[Directionality]-aware alignments.
  ///  * [AlignmentDirectional] for [Directionality]-aware alignments.
  final AlignmentGeometry alignment;

  /// {@template flutter.widgets.constraintsTransform}
  /// The function used to transform the incoming [BoxConstraints], to size
  /// [child].
  ///
  /// The function must return a [BoxConstraints] that is
  /// [BoxConstraints.isNormalized].
  ///
  /// See [ConstraintsTransformBox] for predefined common
  /// [BoxConstraintsTransform]s.
  /// {@endtemplate}
  final BoxConstraintsTransform constraintsTransform;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// {@template flutter.widgets.ConstraintsTransformBox.clipBehavior}
  /// In debug mode, if [clipBehavior] is [Clip.none], and the child overflows
  /// its constraints, a warning will be printed on the console, and black and
  /// yellow striped areas will appear where the overflow occurs. For other
  /// values of [clipBehavior], the contents are clipped accordingly.
  /// {@endtemplate}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  final String _debugTransformLabel;

  @override
  CustomRenderConstraintsTransformBox createRenderObject(BuildContext context) {
    return CustomRenderConstraintsTransformBox(
      textDirection: textDirection ?? Directionality.maybeOf(context),
      alignment: alignment,
      constraintsTransform: constraintsTransform,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant CustomRenderConstraintsTransformBox renderObject) {
    renderObject
      ..textDirection = textDirection ?? Directionality.maybeOf(context)
      ..constraintsTransform = constraintsTransform
      ..alignment = alignment
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));

    final String? debugTransformLabel = _debugTransformLabel.isNotEmpty
        ? _debugTransformLabel
        : _debugKnownTransforms[constraintsTransform];

    if (debugTransformLabel != null) {
      properties.add(DiagnosticsProperty<String>(
          'constraints transform', debugTransformLabel));
    }
  }
}

class CustomRenderConstraintsTransformBox extends RenderAligningShiftedBox
    with DebugOverflowIndicatorMixin {
  /// Creates a [RenderBox] that sizes itself to the child and modifies the
  /// [constraints] before passing it down to that child.
  ///
  /// The [alignment] and [clipBehavior] must not be null.
  CustomRenderConstraintsTransformBox({
    required super.alignment,
    required super.textDirection,
    required BoxConstraintsTransform constraintsTransform,
    super.child,
    Clip clipBehavior = Clip.none,
  })  : _constraintsTransform = constraintsTransform,
        _clipBehavior = clipBehavior;

  /// {@macro flutter.widgets.constraintsTransform}
  BoxConstraintsTransform get constraintsTransform => _constraintsTransform;
  BoxConstraintsTransform _constraintsTransform;
  set constraintsTransform(BoxConstraintsTransform value) {
    if (_constraintsTransform == value) {
      return;
    }
    _constraintsTransform = value;
    // The RenderObject only needs layout if the new transform maps the current
    // `constraints` to a different value, or the render object has never been
    // laid out before.
    final bool needsLayout =
        _childConstraints == null || _childConstraints != value(constraints);
    if (needsLayout) {
      markNeedsLayout();
    }
  }

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// {@macro flutter.widgets.ConstraintsTransformBox.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  Clip get clipBehavior => _clipBehavior;
  Clip _clipBehavior;
  set clipBehavior(Clip value) {
    if (value != _clipBehavior) {
      _clipBehavior = value;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return super.computeMinIntrinsicHeight(
      constraintsTransform(BoxConstraints(maxWidth: width)).maxWidth,
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return super.computeMaxIntrinsicHeight(
      constraintsTransform(BoxConstraints(maxWidth: width)).maxWidth,
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return super.computeMinIntrinsicWidth(
      constraintsTransform(BoxConstraints(maxHeight: height)).maxHeight,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return super.computeMaxIntrinsicWidth(
      constraintsTransform(BoxConstraints(maxHeight: height)).maxHeight,
    );
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Size? childSize =
        child?.getDryLayout(constraintsTransform(constraints));
    return childSize == null
        ? constraints.smallest
        : constraints.constrain(childSize);
  }

  Rect _overflowContainerRect = Rect.zero;
  Rect _overflowChildRect = Rect.zero;
  bool _isOverflowing = false;

  BoxConstraints? _childConstraints;

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final RenderBox? child = this.child;
    if (child != null) {
      final BoxConstraints childConstraints = constraintsTransform(constraints);
      _childConstraints = childConstraints;
      child.layout(childConstraints, parentUsesSize: true);
      size = constraints.constrain(child.size);
      alignChild();
      final BoxParentData childParentData = child.parentData! as BoxParentData;
      _overflowContainerRect = Offset.zero & size;
      _overflowChildRect = childParentData.offset & child.size;
    } else {
      size = constraints.smallest;
      _overflowContainerRect = Rect.zero;
      _overflowChildRect = Rect.zero;
    }
    _isOverflowing =
        RelativeRect.fromRect(_overflowContainerRect, _overflowChildRect)
            .hasInsets;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // There's no point in drawing the child if we're empty, or there is no
    // child.
    if (child == null || size.isEmpty) {
      return;
    }

    if (!_isOverflowing) {
      super.paint(context, offset);
      return;
    }

    // We have overflow and the clipBehavior isn't none. Clip it.
    _clipRectLayer.layer = context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      super.paint,
      clipBehavior: clipBehavior,
      oldLayer: _clipRectLayer.layer,
    );

    // Display the overflow indicator if clipBehavior is Clip.none.

    paintOverflowIndicator(
        context, offset, _overflowContainerRect, _overflowChildRect);
  }

  final LayerHandle<ClipRectLayer> _clipRectLayer =
      LayerHandle<ClipRectLayer>();

  @override
  void dispose() {
    _clipRectLayer.layer = null;
    super.dispose();
  }

  @override
  Rect? describeApproximatePaintClip(RenderObject child) {
    switch (clipBehavior) {
      case Clip.none:
        return null;
      case Clip.hardEdge:
      case Clip.antiAlias:
      case Clip.antiAliasWithSaveLayer:
        return _isOverflowing ? Offset.zero & size : null;
    }
  }

  @override
  String toStringShort() {
    String header = super.toStringShort();
    if (_isOverflowing) {
      header += ' OVERFLOWING';
    }
    return header;
  }
}

// Describes which side the region data overflows on.
enum _OverflowSide {
  left,
  top,
  bottom,
  right,
}

// Data used by the DebugOverflowIndicator to manage the regions and labels for
// the indicators.
class _OverflowRegionData {
  const _OverflowRegionData({
    required this.rect,
    this.label = '',
    this.labelOffset = Offset.zero,
    this.rotation = 0.0,
    required this.side,
  });

  final Rect rect;
  final String label;
  final Offset labelOffset;
  final double rotation;
  final _OverflowSide side;
}

/// An mixin indicator that is drawn when a [RenderObject] overflows its
/// container.
///
/// This is used by some RenderObjects that are containers to show where, and by
/// how much, their children overflow their containers. These indicators are
/// typically only shown in a debug build (where the call to
/// [paintOverflowIndicator] is surrounded by an assert).
///
/// This class will also print a debug message to the console when the container
/// overflows. It will print on the first occurrence, and once after each time that
/// [reassemble] is called.
///
/// {@tool snippet}
///
/// ```dart
/// class MyRenderObject extends RenderAligningShiftedBox with DebugOverflowIndicatorMixin {
///   MyRenderObject({
///     super.alignment = Alignment.center,
///     required super.textDirection,
///     super.child,
///   });
///
///   late Rect _containerRect;
///   late Rect _childRect;
///
///   @override
///   void performLayout() {
///     // ...
///     final BoxParentData childParentData = child!.parentData! as BoxParentData;
///     _containerRect = Offset.zero & size;
///     _childRect = childParentData.offset & child!.size;
///   }
///
///   @override
///   void paint(PaintingContext context, Offset offset) {
///     // Do normal painting here...
///     // ...
///
///     assert(() {
///       paintOverflowIndicator(context, offset, _containerRect, _childRect);
///       return true;
///     }());
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [RenderConstraintsTransformBox] and [RenderFlex] for examples of classes
///    that use this indicator mixin.
mixin DebugOverflowIndicatorMixin on RenderObject {
  static const Color _black = Color(0xBF000000);
  static const Color _yellow = Color(0xBFFFFF00);
  // The fraction of the container that the indicator covers.
  static const double _indicatorFraction = 0.1;
  static const double _indicatorFontSizePixels = 7.5;
  static const double _indicatorLabelPaddingPixels = 1.0;
  static const TextStyle _indicatorTextStyle = TextStyle(
    color: Color(0xFF900000),
    fontSize: _indicatorFontSizePixels,
    fontWeight: FontWeight.w800,
  );
  static final Paint _indicatorPaint = Paint()
    ..shader = ui.Gradient.linear(
      Offset.zero,
      const Offset(10.0, 10.0),
      <Color>[_black, _yellow, _yellow, _black],
      <double>[0.25, 0.25, 0.75, 0.75],
      TileMode.repeated,
    );
  static final Paint _labelBackgroundPaint = Paint()
    ..color = const Color(0xFFFFFFFF);

  final List<TextPainter> _indicatorLabel = List<TextPainter>.filled(
    _OverflowSide.values.length,
    TextPainter(textDirection: TextDirection.ltr), // This label is in English.
  );

  @override
  void dispose() {
    for (final TextPainter painter in _indicatorLabel) {
      painter.dispose();
    }
    super.dispose();
  }

  // Set to true to trigger a debug message in the console upon
  // the next paint call. Will be reset after each paint.
  bool _overflowReportNeeded = true;

  String _formatPixels(double value) {
    assert(value > 0.0);
    final String pixels;
    if (value > 10.0) {
      pixels = value.toStringAsFixed(0);
    } else if (value > 1.0) {
      pixels = value.toStringAsFixed(1);
    } else {
      pixels = value.toStringAsPrecision(3);
    }
    return pixels;
  }

  List<_OverflowRegionData> _calculateOverflowRegions(
      RelativeRect overflow, Rect containerRect) {
    final List<_OverflowRegionData> regions = <_OverflowRegionData>[];
    if (overflow.left > 0.0) {
      final Rect markerRect = Rect.fromLTWH(
        0.0,
        0.0,
        containerRect.width * _indicatorFraction,
        containerRect.height,
      );
      regions.add(_OverflowRegionData(
        rect: markerRect,
        label: 'LEFT OVERFLOWED BY ${_formatPixels(overflow.left)} PIXELS',
        labelOffset: markerRect.centerLeft +
            const Offset(
                _indicatorFontSizePixels + _indicatorLabelPaddingPixels, 0.0),
        rotation: math.pi / 2.0,
        side: _OverflowSide.left,
      ));
    }
    if (overflow.right > 0.0) {
      final Rect markerRect = Rect.fromLTWH(
        containerRect.width * (1.0 - _indicatorFraction),
        0.0,
        containerRect.width * _indicatorFraction,
        containerRect.height,
      );
      regions.add(_OverflowRegionData(
        rect: markerRect,
        label: 'RIGHT OVERFLOWED BY ${_formatPixels(overflow.right)} PIXELS',
        labelOffset: markerRect.centerRight -
            const Offset(
                _indicatorFontSizePixels + _indicatorLabelPaddingPixels, 0.0),
        rotation: -math.pi / 2.0,
        side: _OverflowSide.right,
      ));
    }
    if (overflow.top > 0.0) {
      final Rect markerRect = Rect.fromLTWH(
        0.0,
        0.0,
        containerRect.width,
        containerRect.height * _indicatorFraction,
      );
      regions.add(_OverflowRegionData(
        rect: markerRect,
        label: 'TOP OVERFLOWED BY ${_formatPixels(overflow.top)} PIXELS',
        labelOffset: markerRect.topCenter +
            const Offset(0.0, _indicatorLabelPaddingPixels),
        side: _OverflowSide.top,
      ));
    }
    if (overflow.bottom > 0.0) {
      final Rect markerRect = Rect.fromLTWH(
        0.0,
        containerRect.height * (1.0 - _indicatorFraction),
        containerRect.width,
        containerRect.height * _indicatorFraction,
      );
      regions.add(_OverflowRegionData(
        rect: markerRect,
        label: 'BOTTOM OVERFLOWED BY ${_formatPixels(overflow.bottom)} PIXELS',
        labelOffset: markerRect.bottomCenter -
            const Offset(
                0.0, _indicatorFontSizePixels + _indicatorLabelPaddingPixels),
        side: _OverflowSide.bottom,
      ));
    }
    return regions;
  }

  void _reportOverflow(
      RelativeRect overflow, List<DiagnosticsNode>? overflowHints) {
    overflowHints ??= <DiagnosticsNode>[];
    if (overflowHints.isEmpty) {
      overflowHints.add(ErrorDescription(
        'The edge of the $runtimeType that is '
        'overflowing has been marked in the rendering with a yellow and black '
        'striped pattern. This is usually caused by the contents being too big '
        'for the $runtimeType.',
      ));
      overflowHints.add(ErrorHint(
        'This is considered an error condition because it indicates that there '
        'is content that cannot be seen. If the content is legitimately bigger '
        'than the available space, consider clipping it with a ClipRect widget '
        'before putting it in the $runtimeType, or using a scrollable '
        'container, like a ListView.',
      ));
    }

    final List<String> overflows = <String>[
      if (overflow.left > 0.0)
        '${_formatPixels(overflow.left)} pixels on the left',
      if (overflow.top > 0.0)
        '${_formatPixels(overflow.top)} pixels on the top',
      if (overflow.bottom > 0.0)
        '${_formatPixels(overflow.bottom)} pixels on the bottom',
      if (overflow.right > 0.0)
        '${_formatPixels(overflow.right)} pixels on the right',
    ];
    String overflowText = '';
    assert(overflows.isNotEmpty,
        "Somehow $runtimeType didn't actually overflow like it thought it did.");
    switch (overflows.length) {
      case 1:
        overflowText = overflows.first;
        break;
      case 2:
        overflowText = '${overflows.first} and ${overflows.last}';
        break;
      default:
        overflows[overflows.length - 1] =
            'and ${overflows[overflows.length - 1]}';
        overflowText = overflows.join(', ');
    }
    // TODO(jacobr): add the overflows in pixels as structured data so they can
    // be visualized in debugging tools.
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: FlutterError('A $runtimeType overflowed by $overflowText.'),
        library: 'rendering library',
        context: ErrorDescription('during layout'),
        informationCollector: () => <DiagnosticsNode>[
          // debugCreator should only be set in DebugMode, but we want the
          // treeshaker to know that.
          if (debugCreator != null) DiagnosticsDebugCreator(debugCreator!),
          ...overflowHints!,
          describeForError('The specific $runtimeType in question is'),
          // TODO(jacobr): this line is ascii art that it would be nice to
          // handle a little more generically in GUI debugging clients in the
          // future.
          DiagnosticsNode.message('◢◤' * (FlutterError.wrapWidth ~/ 2),
              allowWrap: false),
        ],
      ),
    );
  }

  /// To be called when the overflow indicators should be painted.
  ///
  /// Typically only called if there is an overflow, and only from within a
  /// debug build.
  ///
  /// See example code in [DebugOverflowIndicatorMixin] documentation.
  void paintOverflowIndicator(
    PaintingContext context,
    Offset offset,
    Rect containerRect,
    Rect childRect, {
    List<DiagnosticsNode>? overflowHints,
  }) {
    final RelativeRect overflow =
        RelativeRect.fromRect(containerRect, childRect);

    if (overflow.left <= 0.0 &&
        overflow.right <= 0.0 &&
        overflow.top <= 0.0 &&
        overflow.bottom <= 0.0) {
      return;
    }

    final List<_OverflowRegionData> overflowRegions =
        _calculateOverflowRegions(overflow, containerRect);
    for (final _OverflowRegionData region in overflowRegions) {
      context.canvas.drawRect(region.rect.shift(offset), _indicatorPaint);
      final TextSpan? textSpan =
          _indicatorLabel[region.side.index].text as TextSpan?;
      if (textSpan?.text != region.label) {
        _indicatorLabel[region.side.index].text = TextSpan(
          text: region.label,
          style: _indicatorTextStyle,
        );
        _indicatorLabel[region.side.index].layout();
      }

      final Offset labelOffset = region.labelOffset + offset;
      final Offset centerOffset =
          Offset(-_indicatorLabel[region.side.index].width / 2.0, 0.0);
      final Rect textBackgroundRect =
          centerOffset & _indicatorLabel[region.side.index].size;
      context.canvas.save();
      context.canvas.translate(labelOffset.dx, labelOffset.dy);
      context.canvas.rotate(region.rotation);
      context.canvas.drawRect(textBackgroundRect, _labelBackgroundPaint);
      _indicatorLabel[region.side.index].paint(context.canvas, centerOffset);
      context.canvas.restore();
    }

    if (_overflowReportNeeded) {
      _overflowReportNeeded = false;
      _reportOverflow(overflow, overflowHints);
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    // Users expect error messages to be shown again after hot reload.
    assert(() {
      _overflowReportNeeded = true;
      return true;
    }());
  }
}
