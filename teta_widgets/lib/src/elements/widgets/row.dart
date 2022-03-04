// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WRow extends StatelessWidget {
  /// Constructor
  const WRow(
    Key? key, {
    required List<CNode> children,
    required CNode node,
    required bool forPlay,
    required FMainAxisAlignment mainAxisAlignment,
    required FCrossAxisAlignment crossAxisAlignment,
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
  })  : _children = children,
        _node = node,
        _forPlay = forPlay,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        _loop = loop,
        _params = params,
        _states = states,
        _dataset = dataset,
        super(key: key);

  final CNode _node;
  final List<CNode> _children;
  final bool _forPlay;
  final FMainAxisAlignment _mainAxisAlignment;
  final FCrossAxisAlignment _crossAxisAlignment;
  final int? _loop;
  final List<VariableObject> _params;
  final List<VariableObject> _states;
  final List<DatasetObject> _dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: _node,
      forPlay: _forPlay,
      child: Row(
        mainAxisAlignment: _mainAxisAlignment.get,
        crossAxisAlignment: _crossAxisAlignment.get,
        mainAxisSize: MainAxisSize.min,
        children: _children.isNotEmpty
            ? _children
                .map(
                  (e) => e.toWidget(
                    loop: _loop,
                    forPlay: _forPlay,
                    params: _params,
                    states: _states,
                    dataset: _dataset,
                  ),
                )
                .toList()
            : [
                PlaceholderChildBuilder(name: _node.intrinsicState.displayName),
              ],
      ),
    );
  }
}
