// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WPositioned extends StatelessWidget {
  /// Returns a Positioned widget in Teta
  const WPositioned(
    final Key? key, {
    required final TetaWidgetState state,
    required final FMargins margins,
    required final bool left,
    required final bool top,
    required final bool right,
    required final bool bottom,
    final CNode? child,
  })  : _state = state,
        _child = child,
        _margins = margins,
        _left = left,
        _top = top,
        _right = right,
        _bottom = bottom,
        super(key: key);

  final TetaWidgetState _state;
  final CNode? _child;
  final FMargins _margins;
  final bool _left;
  final bool _top;
  final bool _right;
  final bool _bottom;

  @override
  Widget build(final BuildContext context) {
    final pos = _margins.get(context);

    return TetaWidget(
      state: _state,
      child: Positioned(
        top: _top ? pos.top : null,
        bottom: _bottom ? pos.bottom : null,
        left: _left ? pos.left : null,
        right: _right ? pos.right : null,
        child: ChildConditionBuilder(
          ValueKey('${_state.node.nid} ${_state.loop}'),
          state: _state,
          child: _child,
        ),
      ),
    );
  }
}
