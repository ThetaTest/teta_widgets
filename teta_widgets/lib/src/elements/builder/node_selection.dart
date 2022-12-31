// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/rendering/find.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

/// Node Selection
class NodeSelection extends StatefulWidget {
  /// Make a widget selectable
  const NodeSelection({
    required this.state,
    required this.child,
    final Key? key,
  }) : super(key: key);

  final TetaWidgetState state;
  final Widget child;

  @override
  NodeSelectionState createState() => NodeSelectionState();
}

class NodeSelectionState extends State<NodeSelection> {
  bool isSelectFromOtherAuthors = false;
  Color authorColor = Colors.transparent;
  String authorNid = '';
  CNode? parent;

  @override
  void initState() {
    parent = FindNodeRendering.findParentByChildrenIds(
      flatList: BlocProvider.of<PageCubit>(context).state.flatList ?? [],
      element: widget.state.node,
    );
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    if (widget.state.forPlay) {
      return _Body(
        state: widget.state,
        child: widget.child,
      );
    }
    return DragAndDropBuilder(
      state: widget.state,
      child: MouseRegion(
        onEnter: (final e) {
          BlocProvider.of<HoverBloc>(context)
              .add(OnHover(node: widget.state.node));
        },
        onExit: (final e) {
          if (parent != null) {
            BlocProvider.of<HoverBloc>(context).add(OnHover(node: parent!));
          }
        },
        child: Listener(
          onPointerDown: (final event) {
            if (event.kind == PointerDeviceKind.mouse &&
                event.buttons == kSecondaryMouseButton) {
              if (widget.state.node.intrinsicState.type != NType.scaffold &&
                  widget.state.node.intrinsicState.type != NType.appBar &&
                  widget.state.node.intrinsicState.type != NType.bottomBar &&
                  widget.state.node.intrinsicState.type != NType.drawer) {
                RightContextMenu.instance.open(
                  event,
                  context,
                  widget.state.node,
                );
              }
            }
          },
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<FocusBloc>(context)
                  .add(OnFocus(node: widget.state.node));
              BlocProvider.of<JumpToCubit>(context)
                  .jumpTo(context, widget.state.node);
            },
            child: _Body(
              state: widget.state,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({final Key? key, required this.state, required this.child})
      : super(key: key);

  final TetaWidgetState state;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final onFocusNodes) {
        return BlocBuilder<HoverBloc, CNode>(
          builder: (final context, final onHover) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: onFocusNodes.firstWhereOrNull(
                                    (final element) =>
                                        element.nid == state.node.nid,
                                  ) !=
                                  null ||
                              onHover.nid == state.node.nid
                          ? primaryColor
                          : Colors.transparent,
                      style: (state.forPlay)
                          ? BorderStyle.none
                          : BorderStyle.solid,
                      width: onFocusNodes.firstWhereOrNull(
                                (final element) =>
                                    element.nid == state.node.nid,
                              ) !=
                              null
                          ? 1
                          : onHover.nid == state.node.nid
                              ? 2
                              : 0,
                    ),
                  ),
                  child: child,
                ),
                if (onFocusNodes.firstWhereOrNull(
                          (final element) => element.nid == state.node.nid,
                        ) !=
                        null ||
                    onHover.nid == state.node.nid)
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: ColoredBox(
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: TDetailLabel(
                          state.node.intrinsicState.displayName,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
