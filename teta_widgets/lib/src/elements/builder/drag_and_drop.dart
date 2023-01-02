import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/rendering/find.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/teta_repositories.dart';
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
    parent = FindNodeRendering.findParentByChildrenIds(
      flatList: BlocProvider.of<PageCubit>(context).state.flatList ?? <CNode>[],
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
    return DragTarget<DragTargetObject>(
      key: key,
      onAccept: (final data) async {
        setState(() {
          isDragging = true;
        });
        final currentIndex =
            parent?.childrenIds.ids.indexOf(widget.state.node.nid);
        if (currentIndex == null) return;
        if (parent == null) return;
        await NodeRepository.addNodeWithCustomIndex(
          node: data.node!,
          parent: parent!,
          index: onLeft ?? false ? currentIndex : currentIndex + 1,
          pageId: BlocProvider.of<PageCubit>(context).state.id,
        );
      },
      onMove: (final details) {
        late bool leftFlag;
        if (widget.state.isVertical) {
          leftFlag = details.offset.dy > key.globalPaintBounds!.top &&
              details.offset.dy <= (key.globalPaintBounds!.height / 2);
        } else {
          leftFlag = details.offset.dx > key.globalPaintBounds!.left &&
              details.offset.dx <= (key.globalPaintBounds!.width / 2);
        }
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
