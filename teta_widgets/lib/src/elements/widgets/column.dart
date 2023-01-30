// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/reorder_children.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WColumn extends StatefulWidget {
  /// Returns [Column] widget in Teta
  const WColumn(
    final Key? key, {
    required this.state,
    required this.children,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.mainAxisSize,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FMainAxisAlignment mainAxisAlignment;
  final FCrossAxisAlignment crossAxisAlignment;
  final FMainAxisSize mainAxisSize;

  @override
  State<WColumn> createState() => _WColumnState();
}

class _WColumnState extends State<WColumn> {
  List<CNode> children = [];

  @override
  void initState() {
    children = widget.children;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: BlocBuilder<FocusBloc, List<int>>(
        builder: (final context, final nodes) {
          if (nodes.length == 1) {
            final index = children
                .indexWhere((final element) => element.nid == nodes.first);
            if (index != -1) {
              return ReorderableColumn(
                onReorder: (final oldIndex, final newIndex) {
                  ReorderChildren.reorder(
                    widget.state.node,
                    children,
                    oldIndex,
                    newIndex,
                  );
                  setState(() {});
                },
                needsLongPressDraggable: false,
                mainAxisSize: widget.mainAxisSize.get,
                mainAxisAlignment: widget.mainAxisAlignment.get,
                crossAxisAlignment: widget.crossAxisAlignment.get,
                children: children.isNotEmpty
                    ? children
                        .map(
                          (final e) => e.toWidget(state: widget.state),
                        )
                        .toList()
                    : [
                        PlaceholderChildBuilder(
                          name: widget.state.node.intrinsicState.displayName,
                          node: widget.state.node,
                          forPlay: widget.state.forPlay,
                        ),
                      ],
              );
            }
          }
          return Column(
            mainAxisSize: widget.mainAxisSize.get,
            mainAxisAlignment: widget.mainAxisAlignment.get,
            crossAxisAlignment: widget.crossAxisAlignment.get,
            children: children.isNotEmpty
                ? children
                    .map(
                      (final e) => e.toWidget(state: widget.state),
                    )
                    .toList()
                : [
                    PlaceholderChildBuilder(
                      name: widget.state.node.intrinsicState.displayName,
                      node: widget.state.node,
                      forPlay: widget.state.forPlay,
                    ),
                  ],
          );
        },
      ),
    );
  }
}
