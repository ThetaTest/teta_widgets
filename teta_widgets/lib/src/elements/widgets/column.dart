// Flutter imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:teta_core/src/services/node_service.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
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

class _WColumnState extends State<WColumn> with AfterLayoutMixin {
  List<Widget> children = [];

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    setState(() {
      children = widget.children
          .map((final e) => e.toWidget(state: widget.state))
          .toList();
    });
  }

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: DragTarget<DragTargetModel>(
        onAccept: (final data) async {
          await sl.get<NodeService>().add(
                dragTarget: data,
                parent: widget.state.node,
                context: context,
                customIndex: null,
              );
        },
        builder: (final context, final candidateData, final rejectedData) {
          return Column(
            mainAxisSize: widget.mainAxisSize.get,
            mainAxisAlignment: widget.mainAxisAlignment.get,
            crossAxisAlignment: widget.crossAxisAlignment.get,
            children: children.isNotEmpty
                ? children
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
