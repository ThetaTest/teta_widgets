/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/elements/nodes/node.dart';

class DraggableNode extends StatefulWidget {
  final bool forPlay;
  final CNode node;
  final Widget child;

  DraggableNode({
    required this.node,
    required this.child,
    required this.forPlay,
  });

  @override
  _DraggableState createState() => _DraggableState();
}

class _DraggableState extends State<DraggableNode> {
  bool isDragged = false;

  @override
  Widget build(BuildContext context) {
    return (widget.forPlay) ? widget.child : widget.child;
    /*LongPressDraggable(
            data: widget.node,
            onDragStarted: () {
              setState(() {
                isDragged = true;
              });
            },
            onDragEnd: (details) {
              setState(() {
                isDragged = false;
              });
            },
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                isDragged = false;
              });
            },
            feedback: widget.child,
            child: widget.child);*/
  }
}
*/
