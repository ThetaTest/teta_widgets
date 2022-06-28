import 'package:flutter/material.dart';

class GradientSwiper extends StatefulWidget {
  const GradientSwiper({
    required this.child,
    final Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  _GradientSwiperSFWState createState() => _GradientSwiperSFWState();
}

class _GradientSwiperSFWState extends State<GradientSwiper> {
  Offset position = const Offset(100, 100);
  double prevScale = 1;
  double scale = 1;

  final GlobalKey _key = GlobalKey();
  late double xOff, yOff;

  @override
  void initState() {
    _getRenderOffsets();
    super.initState();
  }

  void _getRenderOffsets() {
    final renderBoxWidget =
        _key.currentContext?.findRenderObject() as RenderBox?;
    final offset = renderBoxWidget?.localToGlobal(Offset.zero);

    print('offset: $offset');
    yOff = offset?.dy ?? 0;
    xOff = offset?.dx ?? 0;
  }

  void _afterLayout(final dynamic _) {
    _getRenderOffsets();
  }

  void updatePosition(final Offset newPosition) {
    setState(
      () => position = Offset(newPosition.dx - xOff, newPosition.dx - yOff),
    );
    print(position);
  }

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final context, final constraints) => Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.amber.withOpacity(.4)),
          ),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              maxSimultaneousDrags: 1,
              feedback: widget.child,
              childWhenDragging: Opacity(
                opacity: .3,
                child: widget.child,
              ),
              onDragEnd: (final details) => updatePosition(details.offset),
              child: Transform.scale(
                scale: scale,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
