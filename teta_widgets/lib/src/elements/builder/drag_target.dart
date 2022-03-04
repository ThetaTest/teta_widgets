/*import 'package:fast_immutable_collections/fast_immutable_collections.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nil/nil.dart';

// Project imports:
import 'package:mobile_editor/src/blocs/focus/index.dart';
import 'package:mobile_editor/src/blocs/focus_page/bloc.dart';
import 'package:mobile_editor/src/blocs/focus_project/index.dart';
import 'package:mobile_editor/src/blocs/nodes/index.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/drag_target.dart';
import 'package:mobile_editor/src/models/page.dart';
import 'package:mobile_editor/src/repositories/node.dart';

class DragTargetWidget extends StatefulWidget {
  DragTargetWidget({
    Key? key,
    required this.node,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final CNode _node;
  final double? _width;
  final double? _height;
  final Widget? _child;

  @override
  _DragTargetState createState() => _DragTargetState();
}

class _DragTargetState extends State<DragTargetWidget> {
  bool isActive = false;
  bool flagInto = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusProjectBloc, FocusProjectState>(
      builder: (context, prjState) {
        if (prjState is ProjectLoaded)
          return BlocBuilder<FocusPageBloc, PageObject>(
            builder: (context, pageState) {
              return BlocBuilder<NodesBloc, List<CNode>>(
                builder: (context, nodesState) {
                  return DragTarget<DragTargetObject>(
                    builder: (context, list, list2) {
                      return Opacity(
                          opacity: isActive ? 0.5 : 1, child: widget.child);
                    },
                    onMove: (details) {
                      if (!flagInto) {
                        BlocProvider.of<FocusBloc>(context)
                          ..add(OnFocus(node: widget.node));
                        setState(() {
                          flagInto = true;
                          isActive = true;
                        });
                      }
                    },
                    onAccept: (item) {
                      setState(() {
                        isActive = true;
                      });
                      NodeRepository.addNode(
                        prj: prjState.prj,
                        page: pageState,
                        nodes: nodesState,
                        parent: widget.node,
                        index: (widget.node.children != null)
                            ? widget.node.children!.length.toDouble()
                            : 0,
                        item: item,
                        context: context,
                      );
                      setState(() {
                        isActive = false;
                        flagInto = false;
                      });
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
