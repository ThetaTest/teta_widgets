// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/rendering/find.dart';
import 'package:teta_core/src/repositories/actions/remove_node_between_nodes.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class DeleteControl extends StatefulWidget {
  const DeleteControl({
    required this.node,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final Function(bool) callBack;

  @override
  DeleteControlState createState() => DeleteControlState();
}

class DeleteControlState extends State<DeleteControl> {
  double? height;
  double? flag;

  @override
  Widget build(final BuildContext context) {
    height = MediaQuery.of(context).size.height;
    final parentOfNode = FindNodeRendering.findParentByChildrenIds(
      flatList: BlocProvider.of<FlatListBloc>(context).state,
      element: widget.node,
    );
    final prjState =
        BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
    final pageState = BlocProvider.of<FocusPageBloc>(context).state;
    if (widget.node.intrinsicState.canHave ==
        parentOfNode!.intrinsicState.canHave) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 4,
          right: 4,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TActionLabel(
              'Delete',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CDangerousButton(
                label: 'Delete This Node Only',
                callback: () async => removeNodeBetweenNodes(
                  context: context,
                  nodes: BlocProvider.of<FlatListBloc>(context).state,
                  node: widget.node as NDynamic,
                  prj: prjState.prj,
                  page: pageState,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CDangerousButton(
                label: widget.node.intrinsicState.canHave == ChildrenEnum.none
                    ? 'Delete'
                    : widget.node.intrinsicState.canHave == ChildrenEnum.child
                        ? 'Delete with child'
                        : 'Delete with children',
                callback: delete,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TActionLabel(
            'Delete',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CDangerousButton(
              label: widget.node.intrinsicState.canHave == ChildrenEnum.none
                  ? 'Delete'
                  : widget.node.intrinsicState.canHave == ChildrenEnum.child
                      ? 'Delete with child'
                      : 'Delete with children',
              callback: delete,
            ),
          ),
        ],
      ),
    );
  }

  void delete() => widget.callBack(true);

  void showPicker() {
    showDialog<void>(
      context: context,
      builder: (final context) {
        final cubit = GoogleFontsCubit();
        return BlocProvider<GoogleFontsCubit>(
          create: (final context) => cubit,
          child: AlertDialog(
            backgroundColor: const Color(0xFF222222),
            title: const THeadline2(
              'Are you sure you wanna delete me?',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: delete,
                child: const TActionLabel(
                  'Delete',
                  color: Colors.red,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(null);
                },
                child: const TActionLabel(
                  'Cancel',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
