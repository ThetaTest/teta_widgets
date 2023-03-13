import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/rendering/find.dart';
import 'package:teta_core/src/services/node_service.dart';
import 'package:teta_core/teta_core.dart';
import '../../core/teta_widget/index.dart';
import '../index.dart';

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
  bool canReceiveDrag = false;
  bool isDragging = false;
  bool? onLeft;
  CNode? parent;

  @override
  void initState() {
    final pageState = context.read<PageCubit>().state;
    if (pageState is! PageLoaded) return;
    parent = sl.get<FindNodeRendering>().findParentByChildrenIds(
          flatList: pageState.page.flatList,
          element: widget.state.node,
        );
    canReceiveDrag = parent?.globalType == NType.row ||
        parent?.globalType == NType.column ||
        parent?.globalType == NType.listView;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    if (!canReceiveDrag) return widget.child;

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: (widget.state.isVertical)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _DragTarget(
                        parent: parent!,
                        state: widget.state,
                        startAligned: true,
                      ),
                    ),
                    Expanded(
                      child: _DragTarget(
                        parent: parent!,
                        state: widget.state,
                        startAligned: false,
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _DragTarget(
                        parent: parent!,
                        state: widget.state,
                        startAligned: true,
                      ),
                    ),
                    Expanded(
                      child: _DragTarget(
                        parent: parent!,
                        state: widget.state,
                        startAligned: false,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _DragTarget extends StatefulWidget {
  const _DragTarget({
    required this.state,
    required this.parent,
    required this.startAligned,
  });

  final TetaWidgetState state;
  final CNode parent;
  final bool startAligned;

  @override
  State<_DragTarget> createState() => _DragTargetState();
}

class _DragTargetState extends State<_DragTarget> {
  bool isActive = false;

  @override
  Widget build(final BuildContext context) {
    return DragTarget<DragTargetModel>(
      onAccept: (final data) async {
        //context.read<DragCubit>().update(DragState.active);
        setState(() {
          isActive = true;
        });
        final currentIndex =
            widget.parent.childrenIds.ids.indexOf(widget.state.node.nid);
        await sl.get<NodeService>().add(
              dragTarget: data,
              parent: widget.parent,
              context: context,
              customIndex:
                  widget.startAligned ? currentIndex : currentIndex + 1,
            );
        //context.read<DragCubit>().update(DragState.disable);
      },
      onWillAccept: (final details) {
        //context.read<DragCubit>().update(DragState.active);
        setState(() {
          isActive = true;
        });
        return true;
      },
      onLeave: (final details) {
        //context.read<DragCubit>().update(DragState.disable);
        setState(() {
          isActive = false;
        });
      },
      builder: (final context, final candidateData, final rejectedData) {
        if (!isActive) {
          return const SizedBox();
        }
        return widget.state.isVertical
            ? widget.startAligned
                ? const Align(
                    alignment: Alignment.topCenter,
                    child: TContainer(
                      margin: EI.smH,
                      height: 5,
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  )
                : const Align(
                    alignment: Alignment.bottomCenter,
                    child: TContainer(
                      margin: EI.smH,
                      height: 5,
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  )
            : widget.startAligned
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: TContainer(
                      margin: EI.smH,
                      width: 5,
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  )
                : const Align(
                    alignment: Alignment.topRight,
                    child: TContainer(
                      margin: EI.smH,
                      width: 5,
                      decoration: BoxDecoration(color: Colors.red),
                    ),
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
