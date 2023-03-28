/*import 'package:fast_immutable_collections/fast_immutable_collections.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/flat_list/index.dart';
import 'package:mobile_editor/src/blocs/focus_page/bloc.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/page.dart';
import 'package:mobile_editor/src/rendering/find.dart';
import 'package:mobile_editor/src/repositories/node.dart';
import 'package:nil/nil.dart';

class InsideDragTargetWidget extends StatefulWidget {
  final CNode node;
  final double? width;
  final double? height;
  final double? index;
  InsideDragTargetWidget(
      {Key? key, required this.node, this.width, this.height, this.index})
      : super(key: key);

  @override
  _InsideDragTargetWidgetState createState() => _InsideDragTargetWidgetState();
}

class _InsideDragTargetWidgetState extends State<InsideDragTargetWidget> {
  bool isActive = false;
  bool flagInto = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusProjectBloc, FocusProjectState>(
      builder: (context, prjState) {
        if (prjState is ProjectLoaded)
          return BlocBuilder<PageCubit, PageObject>(
            builder: (context, pageState) {
              return BlocBuilder<FlatListBloc, List<CNode>>(
                builder: (context, nodesState) {
                  return DragTarget<CNode>(
                    builder: (context, list, list2) {
                      return Container(
                        height: 10,
                        width: double.maxFinite,
                        color: isActive
                            ? Colors.blueAccent.withOpacity(0.5)
                            : Colors.transparent,
                      );
                    },
                    onMove: (details) {
                      if (!flagInto) {
                        setState(() {
                          flagInto = true;
                          isActive = true;
                        });
                      }
                    },
                    onAccept: (item) {
                      nodesState.forEach((element) {
                        if (element.childrenIds != null) {
                          if (element.childrenIds.get.contains(item.nid)) {
                            final oldChildrenIds = element.childrenIds;
                            element.childrenIds.ids!.remove(item.nid);
                            NodeRepository(context: context).changeChildrenIds(
                              prjId: prjState.prj.id,
                              pageId: pageState.id!,
                              node: element,
                              old: oldChildrenIds,
                            );
                          }
                        }
                      });
                      if (widget.node.intrinsicState.canHaveChildren) {
                        // l'utente sta aggiungendo l'elemento ad un nodo con la possibilità di avere figli
                        setState(() {
                          isActive = true;
                        });
                        // widget.node prevedepiù figli, è possibile quindi inserire item
                        // aggiungi item con parent = widget.node.nid e index = 0
                        if (item.parent != null) {
                          CNode? parentNode;
                          try {
                            parentNode =
                                FindNodeRendering.findParentByChildrenIds(
                                    flatList: nodesState, element: widget.node);
                          } catch (e) {}
                          if (parentNode != null) {
                            final oldChildrenIds = parentNode.childrenIds;
                            parentNode.childrenIds.remove(item.nid);
                            NodeRepository(context: context).changeChildrenIds(
                              prjId: prjState.prj.id,
                              pageId: pageState.id!,
                              node: parentNode,
                              old: oldChildrenIds,
                            );
                          }
                        }
                        final old = widget.node.childrenIds;
                        widget.node.childrenIds.addAt0(item.nid!);
                        setState(() {
                          isActive = false;
                          flagInto = false;
                        });
                        NodeRepository(context: context).changeChildrenIds(
                          prjId: prjState.prj.id,
                          pageId: pageState.id!,
                          node: widget.node,
                          old: old,
                        );
                      } else if (widget.node.intrinsicState.canHaveChild) {
                        // l'utente sta inserendo item in un nodo che può avere un solo figlio
                        if (widget.node.child == null) {
                          // widget.node non ha un figlio, ne può quindi ospitarne uno
                          setState(() {
                            isActive = true;
                          });
                          final old = widget.node.childrenIds;
                          widget.node.childrenIds.addAt0(item.nid!);
                          NodeRepository(context: context).changeChildrenIds(
                            prjId: prjState.prj.id,
                            pageId: pageState.id!,
                            node: widget.node,
                            old: old,
                          );
                          setState(() {
                            isActive = false;
                            flagInto = false;
                          });
                        } else {
                          // widget.node ha già il figlio, quindi l'operazione non può essere eseguita
                          setState(() {
                            flagInto = false;
                            isActive = false;
                          });
                        }
                      } else {
                        if (item.parent != null) {
                          CNode? parentNode;
                          try {
                            parentNode =
                                FindNodeRendering.findParentByChildrenIds(
                                    flatList: nodesState, element: widget.node);
                          } catch (e) {}
                          if (parentNode != null) {
                            final old = parentNode.childrenIds;
                            parentNode.childrenIds.remove(item.nid);
                            NodeRepository(context: context).changeChildrenIds(
                              prjId: prjState.prj.id,
                              pageId: pageState.id!,
                              node: parentNode,
                              old: old,
                            );
                          }
                        }
                        final parentNode =
                            FindNodeRendering.findParentByChildrenIds(
                                flatList: nodesState, element: widget.node);
                        if (parentNode != null) {
                          final old = parentNode.childrenIds;
                          parentNode.childrenIds
                              .add(item.nid!, widget.node.nid!);
                          setState(() {
                            isActive = false;
                            flagInto = false;
                          });
                          NodeRepository(context: context).changeChildrenIds(
                            prjId: prjState.prj.id,
                            pageId: pageState.id!,
                            node: parentNode,
                            old: old,
                          );
                        }
                      }
                    },
                    onLeave: (item) {
                      setState(() {
                        isActive = false;
                        flagInto = false;
                      });
                    },
                  );
                },
              );
            },
          );
        else
          return const SizedBox();
      },
    );
  }
}
*/
