// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

/// Builder
class NodeSelectionBuilder extends StatelessWidget {
  /// Constructor
  const NodeSelectionBuilder({
    required final Widget child,
    required final TetaWidgetState state,
    final Key? key,
  })  : _child = child,
        _state = state,
        super(key: key);

  final Widget _child;
  final TetaWidgetState _state;

  @override
  Widget build(final BuildContext context) {
    return !_state.forPlay
        ? NodeSelection(
            state: _state,
            child: _child,
          )
        : _child;
  }
}
