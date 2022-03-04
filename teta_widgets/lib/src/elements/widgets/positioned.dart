// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WPositioned extends StatelessWidget {
  /// Returns a Positioned widget in Teta
  const WPositioned({
    Key? key,
    required CNode node,
    required FMargins margins,
    required bool left,
    required bool top,
    required bool right,
    required bool bottom,
    required bool forPlay,
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    CNode? child,
    int? loop,
  })  : _child = child,
        _node = node,
        _margins = margins,
        _left = left,
        _top = top,
        _right = right,
        _bottom = bottom,
        _forPlay = forPlay,
        _loop = loop,
        _params = params,
        _states = states,
        _dataset = dataset,
        super(key: key);

  final CNode _node;
  final CNode? _child;
  final FMargins _margins;
  final bool _left;
  final bool _top;
  final bool _right;
  final bool _bottom;
  final bool _forPlay;
  final int? _loop;

  final List<VariableObject> _params;
  final List<VariableObject> _states;
  final List<DatasetObject> _dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: _node,
      forPlay: _forPlay,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final pos = _margins.get(context);
    return Positioned(
      top: _top ? pos.top : null,
      bottom: _bottom ? pos.bottom : null,
      left: _left ? pos.left : null,
      right: _right ? pos.right : null,
      child: ChildConditionBuilder(
        name: _node.intrinsicState.displayName,
        child: _child,
        params: _params,
        states: _states,
        dataset: _dataset,
        forPlay: _forPlay,
        loop: _loop,
      ),
    );
  }
}
