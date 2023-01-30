// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
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
  List<CNode?> parents = [];

  @override
  void initState() {
    final page = (context.read<PageCubit>().state as PageLoaded).page;
    do {
      parents.add(
        sl.get<FindNodeRendering>().findParentByChildrenIds(
              flatList: page.flatList,
              element: widget.state.node,
            ),
      );
    } while (parents.isEmpty);
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
          if (parents.firstOrNull != null) {
            BlocProvider.of<HoverBloc>(context)
                .add(OnHover(node: parents.firstOrNull!));
          }
        },
        child: Listener(
          onPointerDown: (final event) => RightContextMenu.instance.open(
            event,
            context,
            widget.state.node,
          ),
          child: GestureDetector(
            onTap: () {
              if (!BlocProvider.of<FocusBloc>(context)
                  .state
                  .contains(widget.state.node)) {
                BlocProvider.of<FocusBloc>(context)
                    .add(OnFocus(node: widget.state.node));
              }
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

class _Body extends StatefulWidget {
  const _Body({
    final Key? key,
    required this.state,
    required this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final Widget child;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final key = GlobalKey();
  late Widget child;

  @override
  void initState() {
    child = widget.child;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant final _Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child) {
      child = widget.child;
    }
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<int>>(
      builder: (final context, final onFocusNodes) {
        return BlocBuilder<HoverBloc, int>(
          builder: (final context, final onHover) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                DecoratedBox(
                  key: key,
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: onFocusNodes.firstWhereOrNull(
                                    (final element) =>
                                        element == widget.state.node.nid,
                                  ) !=
                                  null ||
                              onHover == widget.state.node.nid
                          ? primaryColor
                          : Colors.transparent,
                      style: (widget.state.forPlay)
                          ? BorderStyle.none
                          : BorderStyle.solid,
                      width: onFocusNodes.firstWhereOrNull(
                                (final element) =>
                                    element == widget.state.node.nid,
                              ) !=
                              null
                          ? 1
                          : onHover == widget.state.node.nid
                              ? 2
                              : 0,
                    ),
                  ),
                  child: child,
                ),
                if (onFocusNodes.firstWhereOrNull(
                          (final element) => element == widget.state.node.nid,
                        ) !=
                        null ||
                    onHover == widget.state.node.nid)
                  Transform.translate(
                    offset: Offset(
                      0,
                      (key.globalPaintBounds?.top ?? 0) < 100
                          ? (key.globalPaintBounds?.height ?? 0)
                          : -20,
                    ),
                    child: ColoredBox(
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: TDetailLabel(
                          widget.state.node.intrinsicState.displayName,
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
