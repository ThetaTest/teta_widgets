// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WPositioned extends StatelessWidget {
  /// Returns a Positioned widget in Teta
  const WPositioned(
    final Key? key, {
    required final CNode node,
    required final FMargins margins,
    required final bool left,
    required final bool top,
    required final bool right,
    required final bool bottom,
    required final bool forPlay,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    final CNode? child,
    final int? loop,
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
  Widget build(final BuildContext context) {
    final pos = _margins.get(context);

    return NodeSelectionBuilder(
      node: _node,
      forPlay: _forPlay,
      child: Positioned(
        top: _top ? pos.top : null,
        bottom: _bottom ? pos.bottom : null,
        left: _left ? pos.left : null,
        right: _right ? pos.right : null,
        child: GestureBuilderBase.get(
          context: context,
          node: _node,
          params: _params,
          states: _states,
          dataset: _dataset,
          forPlay: _forPlay,
          loop: _loop,
          child: ChildConditionBuilder(
            ValueKey('${_node.nid} $_loop'),
            name: _node.intrinsicState.displayName,
            node: _node,
            child: _child,
            params: _params,
            states: _states,
            dataset: _dataset,
            forPlay: _forPlay,
            loop: _loop,
          ),
        ),
      ),
    );
  }
}
