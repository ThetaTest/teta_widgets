// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/blocs/index.dart';
import 'package:teta_core/src/cubits/jump_to.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/rendering/find.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Node Selection
class NodeSelection extends StatefulWidget {
  /// Make a widget selectable
  const NodeSelection({
    required this.node,
    required this.child,
    required this.forPlay,
    required this.nid,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final Widget child;
  final bool forPlay;
  final int nid;

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
      flatList: BlocProvider.of<FlatListBloc>(context).state,
      element: widget.node,
    );
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return MouseRegion(
      onEnter: (final e) {
        BlocProvider.of<HoverBloc>(context).add(OnHover(node: widget.node));
      },
      onExit: (final e) {
        if (parent != null) {
          BlocProvider.of<HoverBloc>(context).add(OnHover(node: parent!));
        }
      },
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<FocusBloc>(context).add(OnFocus(node: widget.node));
        },
        onDoubleTap: () {
          BlocProvider.of<FocusBloc>(context).add(OnFocus(node: widget.node));
          BlocProvider.of<JumpToCubit>(context).jumpTo(context, widget.node);
        },
        child: body(),
      ),
    );
    /*return BlocBuilder<AuthorsBloc, List<AuthorObject>>(
      builder: (context, authorsState) {
        var authorColor = Colors.transparent;
        var isSelectFromOtherAuthors = false;
        var isHoveredFromOtherAuthors = false;
        final index = authorsState.indexWhere((element) =>
            element.focusNode == widget.node.nid ||
            element.hoverNode == widget.node.nid);
        if (index != -1) {
          final item = authorsState[index];
          final userState = BlocProvider.of<AuthenticationBloc>(context).state
              as Authenticated;
          if (item.id != userState.user.id &&
              item.focusNode != BlocProvider.of<FocusBloc>(context).state.nid) {
            if (item.focusNode == widget.node.nid) {
              isSelectFromOtherAuthors = item.isOnline ?? false;
              authorColor = item.color!;
            } else {
              isHoveredFromOtherAuthors = item.isOnline ?? false;
              authorColor = item.color!;
            }
          } else {
            authorColor = Colors.transparent;
            isSelectFromOtherAuthors = false;
          }
        }
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              return BlocBuilder<FocusProjectBloc, FocusProjectState>(
                builder: (context, prjState) {
                  if (prjState is ProjectLoaded) {
                    return InkWell(
                      onTap: () {
                        if (!widget.forPlay) {
                          BlocProvider.of<FocusBloc>(context)
                              .add(OnFocus(node: widget.node));
                          if (BlocProvider.of<PanelsBloc>(context).state ==
                              PanelsEnum.tutorials) {
                            BlocProvider.of<PanelsBloc>(context)
                                .add(ChangeIndex(type: PanelsEnum.none));
                          }
                          if (BlocProvider.of<AuthorsBloc>(context)
                                  .state
                                  .where((element) =>
                                      element.isOnline! &&
                                      element.page ==
                                          BlocProvider.of<FocusPageBloc>(
                                                  context)
                                              .state
                                              .id)
                                  .length >
                              1) {
                            ProjectRepository.setFocusNode(
                              prjId: prjState.prj.id,
                              userId: authState.user.id,
                              nodeId: widget.node.nid,
                            );
                          }
                        }
                      },
                      child: MouseRegion(
                        onEnter: (e) {
                          BlocProvider.of<HoverBloc>(context)
                              .add(OnHover(node: widget.node));
                        },
                        onExit: (e) {
                          if (parent != null) {
                            BlocProvider.of<HoverBloc>(context)
                                .add(OnHover(node: parent!));
                          }
                        },
                        child: body(
                          authState,
                          prjState,
                          authorColor,
                          isSelectFromOtherAuthors,
                          isHoveredFromOtherAuthors,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              );
            }
            return const SizedBox();
          },
        );
      },
    );*/
  }

  Widget body() {
    return BlocBuilder<FocusBloc, List<CNode>>(
      buildWhen: (final previous, final current) => current != previous,
      builder: (final context, final onFocusNodes) {
        return BlocBuilder<HoverBloc, CNode>(
          buildWhen: (final previous, final current) => current != previous,
          builder: (final context, final onHover) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: onFocusNodes.firstWhereOrNull(
                            (final element) =>
                                element.nid == widget.node.nid ||
                                onHover.nid == widget.node.nid,
                          ) !=
                          null
                      ? primaryColor
                      : Colors.transparent,
                  style:
                      (widget.forPlay) ? BorderStyle.none : BorderStyle.solid,
                  width: onFocusNodes.firstWhereOrNull(
                            (final element) => element.nid == widget.node.nid,
                          ) !=
                          null
                      ? 1
                      : onHover.nid == widget.node.nid
                          ? 2
                          : 0,
                ),
              ),
              child: widget.child,
            );
            /*Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: (widget.node.canHaveChildren(widget.node.type))
                      ? InsideDragTargetWidget(
                          node: widget.node,
                          width: double.maxFinite,
                          height: 10,
                          index: widget.index,
                        )
                      : const SizedBox(),
                ),*/
          },
        );
      },
    );
  }
}
