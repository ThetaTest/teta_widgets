// Flutter imports:

import 'package:flutter/material.dart';
import 'package:teta_core/src/services/node_service.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/elements/builder/drag_list.dart';

// ignore_for_file: public_member_api_docs

class WColumn extends StatelessWidget {
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
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: DragTarget<DragTargetModel>(
        onAccept: (final data) async {
          await sl.get<NodeService>().add(
                dragTarget: data,
                parent: state.node,
                context: context,
                customIndex: null,
              );
        },
        builder: (final context, final candidateData, final rejectedData) {
          return DragAndDropList(
            direction: DragAndDropDirection.vertical,
            mainAxisSize: mainAxisSize.get,
            mainAxisAlignment: mainAxisAlignment.get,
            crossAxisAlignment: crossAxisAlignment.get,
            children: children.isNotEmpty
                ? children.map((final e) => e.toWidget(state: state)).toList()
                : [
                    PlaceholderChildBuilder(
                      name: state.node.intrinsicState.displayName,
                      node: state.node,
                      forPlay: state.forPlay,
                    ),
                  ],
          );
        },
      ),
    );
  }
}
