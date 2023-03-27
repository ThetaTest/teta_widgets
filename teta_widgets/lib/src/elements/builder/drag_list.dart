import 'package:flutter/material.dart';

enum DragAndDropDirection { vertical, horizontal }

class DragAndDropList extends StatefulWidget {
  final List<Widget> children;
  final DragAndDropDirection direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const DragAndDropList({
    super.key,
    required this.children,
    required this.direction,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.mainAxisSize,
  });

  @override
  _DragAndDropListState createState() => _DragAndDropListState();
}

class _DragAndDropListState extends State<DragAndDropList>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<double> _dragStartXPositions;
  late List<double> _dragCurrentXPositions;
  late int _draggingIndex;
  late double _draggingXPosition;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        widget.children.length,
        (_) => AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200)));
    _animations = _controllers
        .map((controller) =>
            Tween<double>(begin: 1.0, end: 0.0).animate(controller))
        .toList();
    _dragStartXPositions = List.filled(widget.children.length, 0.0);
    _dragCurrentXPositions = List.filled(widget.children.length, 0.0);
    _draggingIndex = -1;
    _draggingXPosition = 0.0;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onDragStart(int index, DragStartDetails details) {
    _dragStartXPositions[index] = _getDragStartPosition(details);
    _dragCurrentXPositions[index] = _getDragStartPosition(details);
    _draggingIndex = index;
    _draggingXPosition = details.globalPosition.dx;
  }

  void _onDragUpdate(int index, DragUpdateDetails details) {
    final size = context.size!;
    _dragCurrentXPositions[index] = details.globalPosition.dx;
    final dx = _dragCurrentXPositions[index] - _dragStartXPositions[index];
    final newIndex = (dx / 50).round().clamp(0, widget.children.length - 1);
    if (newIndex != index) {
      _controllers[index].reverse();
      _controllers[newIndex].reverse();
      setState(() {
        final child = widget.children.removeAt(index);
        widget.children.insert(newIndex, child);
        _dragStartXPositions = List.filled(widget.children.length, 0.0);
        _dragCurrentXPositions = List.filled(widget.children.length, 0.0);
        _draggingIndex = newIndex;
      });
    }
    _draggingXPosition = _dragCurrentXPositions[index];
    setState(() {
      _draggingXPosition = _draggingXPosition.clamp(0, size.width);
    });
  }

  void _onDragEnd(int index, DragEndDetails details) {
    _controllers[index].forward();
    if (_draggingIndex != index) {
      _controllers[_draggingIndex].forward();
    }
    _draggingIndex = -1;
    _draggingXPosition = 0.0;
  }

  double _getDragStartPosition(DragStartDetails details) {
    if (widget.direction == DragAndDropDirection.horizontal) {
      return details.globalPosition.dx;
    } else {
      return details.globalPosition.dy;
    }
  }

  double _getDragUpdatePosition(DragUpdateDetails details) {
    if (widget.direction == DragAndDropDirection.horizontal) {
      return details.globalPosition.dx;
    } else {
      return details.globalPosition.dy;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.direction == DragAndDropDirection.vertical) {
      return Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisSize: widget.mainAxisSize,
        children: widget.children,
      );
    }
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      children: widget.children,
    );
  }

  Widget _buildChild(int index, final Widget child) {
    return GestureDetector(
      key: ValueKey('el $index'),
      onPanStart: (details) => _onDragStart(index, details),
      onPanUpdate: (details) => _onDragUpdate(index, details),
      onPanEnd: (details) => _onDragEnd(index, details),
      child: child,
    );
  }
}
