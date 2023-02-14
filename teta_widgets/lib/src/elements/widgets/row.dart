// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/src/services/node_service.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WRow extends StatelessWidget {
  /// Constructor
  const WRow(
    final Key? key, {
    required final TetaWidgetState state,
    required final List<CNode> children,
    required final FMainAxisAlignment mainAxisAlignment,
    required final FCrossAxisAlignment crossAxisAlignment,
    required final FMainAxisSize mainAxisSize,
  })  : _children = children,
        _state = state,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        _mainAxisSize = mainAxisSize,
        super(key: key);

  final TetaWidgetState _state;
  final List<CNode> _children;
  final FMainAxisAlignment _mainAxisAlignment;
  final FCrossAxisAlignment _crossAxisAlignment;
  final FMainAxisSize _mainAxisSize;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: _state,
      child: DragTarget<DragTargetModel>(
        onAccept: (final data) async {
          await sl.get<NodeService>().add(
                dragTarget: data,
                parent: _state.node,
                context: context,
                customIndex: null,
              );
        },
        builder: (final context, final candidateData, final rejectedData) {
          return Row(
            mainAxisAlignment: _mainAxisAlignment.get,
            crossAxisAlignment: _crossAxisAlignment.get,
            mainAxisSize: _mainAxisSize.get,
            children: _children.isNotEmpty
                ? _children
                    .map(
                      (final e) => e.toWidget(
                        state: _state,
                        isVertical: false,
                      ),
                    )
                    .toList()
                : [
                    PlaceholderChildBuilder(
                      name: _state.node.intrinsicState.displayName,
                      node: _state.node,
                      forPlay: _state.forPlay,
                    ),
                  ],
          );
        },
      ),
    );
  }
}
