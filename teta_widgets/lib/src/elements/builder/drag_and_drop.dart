import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/rendering/find.dart';
import 'package:teta_core/src/services/node_service.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';

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
  final key = GlobalKey();

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

  bool isLeft(
    final double pointCoord,
    final double offset,
    final double screenOffset,
    final double sideSize,
  ) {
    return pointCoord - screenOffset > offset - screenOffset &&
        pointCoord - screenOffset < (offset - screenOffset) + (sideSize / 2);
  }

  @override
  Widget build(final BuildContext context) {
    if (!canReceiveDrag) return widget.child;
    return DragTarget<DragTargetModel>(
      key: key,
      onAccept: (final data) async {
        context.read<DragCubit>().update(DragState.active);
        setState(() {
          isDragging = true;
        });
        final currentIndex =
            parent?.childrenIds.ids.indexOf(widget.state.node.nid);
        if (currentIndex == null) return;
        if (parent == null) return;
        await sl.get<NodeService>().add(
              dragTarget: data,
              parent: parent!,
              context: context,
              customIndex: onLeft ?? false ? currentIndex : currentIndex + 1,
            );
      },
      onMove: (final details) {
        late bool leftFlag;
        final screenOffset = context.read<ScreenPositionCubit>().state;
        if (widget.state.isVertical) {
          leftFlag = isLeft(
            details.offset.dy,
            key.globalPaintBounds!.top,
            screenOffset.dy,
            key.globalPaintBounds!.height,
          );
        } else {
          leftFlag = isLeft(
            details.offset.dx,
            key.globalPaintBounds!.left,
            screenOffset.dx,
            key.globalPaintBounds!.width,
          );
        }
        context.read<DragCubit>().update(DragState.active);
        setState(() {
          isDragging = true;
          if (key.globalPaintBounds != null) {
            onLeft = leftFlag;
          }
        });
      },
      onLeave: (final details) {
        context.read<DragCubit>().update(DragState.disable);
        setState(() {
          isDragging = false;
          onLeft = null;
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
              child: widget.state.isVertical
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (onLeft ?? false)
                          TContainer(
                            margin: EI.smH,
                            width: key.globalPaintBounds!.width,
                            height: 5,
                            decoration:
                                const BoxDecoration(color: primaryColor),
                          )
                        else
                          const Spacer(),
                        if (!(onLeft ?? true))
                          TContainer(
                            margin: EI.smH,
                            width: key.globalPaintBounds!.width,
                            height: 5,
                            decoration:
                                const BoxDecoration(color: primaryColor),
                          )
                        else
                          const Spacer(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (onLeft ?? false)
                          TContainer(
                            margin: EI.smV,
                            width: 5,
                            height: key.globalPaintBounds!.height,
                            decoration:
                                const BoxDecoration(color: primaryColor),
                          )
                        else
                          const Spacer(),
                        if (!(onLeft ?? true))
                          TContainer(
                            margin: EI.smV,
                            width: 5,
                            height: key.globalPaintBounds!.height,
                            decoration:
                                const BoxDecoration(color: primaryColor),
                          )
                        else
                          const Spacer(),
                      ],
                    ),
            ),
            Positioned(
              top: (key.globalPaintBounds?.top ?? 0) <
                      (MediaQuery.of(context).size.height / 3)
                  ? (key.globalPaintBounds?.height ?? 0)
                  : -20,
              child: RepaintBoundary(
                child: ColoredBox(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Row(
                      children: [
                        TDetailLabel(
                          'Drop in ${parent!.intrinsicState.displayName}',
                        ),
                      ],
                    ),
                  ),
                ),
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
