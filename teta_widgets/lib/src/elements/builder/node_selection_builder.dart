// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/builder/node_selection.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Builder
class NodeSelectionBuilder extends StatelessWidget {
  /// Constructor
  const NodeSelectionBuilder({
    Key? key,
    required Widget child,
    required CNode node,
    required bool forPlay,
  })  : _child = child,
        _node = node,
        _forPlay = forPlay,
        super(key: key);

  final Widget _child;
  final CNode _node;
  final bool _forPlay;

  @override
  Widget build(BuildContext context) {
    return !_forPlay
        ? NodeSelection(
            node: _node,
            forPlay: _forPlay,
            nid: _node.nid,
            child: _child,
          )
        : _child;
  }
}
