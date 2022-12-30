import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

class DragAndDropBuilder extends StatefulWidget {
  const DragAndDropBuilder({
    final Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<DragAndDropBuilder> createState() => _DragAndDropBuilderState();
}

class _DragAndDropBuilderState extends State<DragAndDropBuilder> {
  bool isDragging = false;

  @override
  Widget build(final BuildContext context) {
    return DragTarget<DragTargetObject>(
      onAccept: (final data) {
        setState(() {
          isDragging = true;
        });
      },
      onMove: (final details) {
        setState(() {
          isDragging = true;
        });
      },
      onLeave: (final details) {
        setState(() {
          isDragging = false;
        });
      },
      builder: (final context, final candidateData, final rejectedData) {
        if (!isDragging) return widget.child;
        return DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: const BoxDecoration(color: Colors.white30),
          child: widget.child,
        );
      },
    );
  }
}
