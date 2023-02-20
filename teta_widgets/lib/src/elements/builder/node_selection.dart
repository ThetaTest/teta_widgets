// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/rendering/find.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class NodeSelection extends StatelessWidget {
  const NodeSelection({
    required this.state,
    required this.child,
    final Key? key,
  }) : super(key: key);

  final TetaWidgetState state;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return _NodeSelection(
      state: state,
      child: child,
    );
  }
}

/// Node Selection
class _NodeSelection extends StatefulWidget {
  /// Make a widget selectable
  const _NodeSelection({
    required this.state,
    required this.child,
    final Key? key,
  }) : super(key: key);

  final TetaWidgetState state;
  final Widget child;

  @override
  NodeSelectionState createState() => NodeSelectionState();
}

class NodeSelectionState extends State<_NodeSelection> {
  final List<CNode?> parents = [];

  @override
  void initState() {
    final page = (context.read<PageCubit>().state as PageLoaded).page;
    parents.addAll(
      sl.get<FindNodeRendering>().findParentsOfElement(
            flatList: page.flatList,
            element: widget.state.node,
          ),
    );
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    if (widget.state.forPlay) {
      return widget.child;
    }
    final dragState = context.watch<DragCubit>().state;
    if (dragState == DragState.active) {
      return DragAndDropBuilder(
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
                  .contains(widget.state.node.nid)) {
                BlocProvider.of<FocusBloc>(context)
                    .add(OnFocus(node: widget.state.node));
              }
              BlocProvider.of<JumpToCubit>(context)
                  .jumpTo(context, widget.state.node);
            },
            child: _Body(
              state: widget.state,
              parents: parents.whereNotNull().toList(),
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
    required this.state,
    required this.child,
    required this.parents,
    final Key? key,
  }) : super(key: key);

  final TetaWidgetState state;
  final Widget child;
  final List<CNode> parents;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final key = GlobalKey();

  @override
  Widget build(final BuildContext context) {
    final onFocusNodes = context.watch<FocusBloc>().state;
    final onHover = context.watch<HoverBloc>().state;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border.all(
              color: onFocusNodes.firstWhereOrNull(
                            (final element) => element == widget.state.node.nid,
                          ) !=
                          null ||
                      onHover == widget.state.node.nid
                  ? primaryColor
                  : Colors.transparent,
              style:
                  (widget.state.forPlay) ? BorderStyle.none : BorderStyle.solid,
              width: onFocusNodes.firstWhereOrNull(
                        (final element) => element == widget.state.node.nid,
                      ) !=
                      null
                  ? 1
                  : onHover == widget.state.node.nid
                      ? 2
                      : 0,
            ),
          ),
          child: widget.child,
        ),
        if (onFocusNodes.firstWhereOrNull(
                  (final element) => element == widget.state.node.nid,
                ) !=
                null ||
            onHover == widget.state.node.nid)
          Positioned(
            top: (key.globalPaintBounds?.top ?? 0) <
                    (MediaQuery.of(context).size.height / 3)
                ? (key.globalPaintBounds?.height ?? 0)
                : -20,
            child: RepaintBoundary(
              child: InkWell(
                onHover: (final e) {
                  context
                      .read<HoverBloc>()
                      .add(OnHover(node: widget.state.node));
                },
                child: ColoredBox(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Row(
                      children: [
                        for (final parent in widget.parents.reversed)
                          _ParentIndicator(
                            name: parent.intrinsicState.displayName,
                          ),
                        TDetailLabel(
                          widget.state.node.intrinsicState.displayName,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ParentIndicator extends StatelessWidget {
  const _ParentIndicator({
    required this.name,
    final Key? key,
  }) : super(key: key);

  final String name;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        _HoverNodeName(name: name),
        TDetailLabel(
          ' > ',
          color: Palette.txtPrimary.withOpacity(0.6),
        ),
      ],
    );
  }
}

class _HoverNodeName extends StatelessWidget {
  const _HoverNodeName({
    required this.name,
    final Key? key,
  }) : super(key: key);

  final String name;

  @override
  Widget build(final BuildContext context) {
    return HoverWidget(
      onHover: (final e) {},
      hoverChild: TDetailLabel(
        name,
      ),
      child: TDetailLabel(
        name,
        color: Palette.txtPrimary.withOpacity(0.6),
      ),
    );
  }
}
