// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

class WSafeArea extends StatelessWidget {
  /// Constructor
  const WSafeArea(
    final Key? key, {
    required final TetaWidgetState state,
    required final bool left,
    required final bool top,
    required final bool right,
    required final bool bottom,
    final CNode? child,
  })  : _state = state,
        _child = child,
        _left = left,
        _top = top,
        _right = right,
        _bottom = bottom,
        super(key: key);

  final TetaWidgetState _state;
  final CNode? _child;
  final bool _left;
  final bool _top;
  final bool _right;
  final bool _bottom;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: _state,
      child: Container(
        padding: EdgeInsets.only(
          top: _top ? 44 : 0,
          bottom: _bottom ? 34 : 0,
          left: _left ? 0 : 0,
          right: _right ? 0 : 0,
        ),
        child: ChildConditionBuilder(
          ValueKey('${_state.node.nid} ${_state.loop}'),
          state: _state,
          child: _child,
        ),
      ),
    );
  }
}
