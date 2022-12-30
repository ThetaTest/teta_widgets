import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';

class DragAndDropBuilder extends StatefulWidget {
  const DragAndDropBuilder({
    required this.state,
    required this.child,
    final Key? key,
  }) : super(key: key);

  final TetaWidgetState state;
  final Widget child;

  @override
  State<DragAndDropBuilder> createState() => _DragAndDropBuilderState();
}

class _DragAndDropBuilderState extends State<DragAndDropBuilder> {
  bool isDragging = false;
  bool? onLeft;
  final key = GlobalKey();

  @override
  Widget build(final BuildContext context) {
    return DragTarget<DragTargetObject>(
      key: key,
      onAccept: (final data) {
        Logger.printDefault('On accept');
        setState(() {
          isDragging = true;
        });
      },
      onMove: (final details) {
        final leftFlag = details.offset.dx > key.globalPaintBounds!.left &&
            details.offset.dx <= key.globalPaintBounds!.center.dx;
        Logger.printSuccess('Is on left: $leftFlag');
        setState(() {
          isDragging = true;
          if (key.globalPaintBounds != null) {
            onLeft = leftFlag;
          }
        });
      },
      onLeave: (final details) {
        setState(() {
          isDragging = false;
          onLeft = false;
        });
      },
      builder: (final context, final candidateData, final rejectedData) {
        if (!isDragging) {
          return widget.child;
        }
        return Stack(
          children: [
            widget.child,
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (onLeft ?? false)
                    TContainer(
                      width: 5,
                      height: key.globalPaintBounds!.height,
                      decoration: const BoxDecoration(color: primaryColor),
                    )
                  else
                    const Spacer(),
                  if (!(onLeft ?? true))
                    TContainer(
                      width: 5,
                      height: key.globalPaintBounds!.height,
                      decoration: const BoxDecoration(color: primaryColor),
                    )
                  else
                    const Spacer(),
                ],
              ),
            ),
          ],
        );
      },
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
