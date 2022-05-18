// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WRow extends StatelessWidget {
  /// Constructor
  const WRow(
    final Key? key, {
    required final List<CNode> children,
    required final CNode node,
    required final bool forPlay,
    required final FMainAxisAlignment mainAxisAlignment,
    required final FCrossAxisAlignment crossAxisAlignment,
    required final FMainAxisSize mainAxisSize,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    final int? loop,
  })  : _children = children,
        _node = node,
        _forPlay = forPlay,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        _mainAxisSize = mainAxisSize,
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
  final FMainAxisSize _mainAxisSize;
  final int? _loop;
  final List<VariableObject> _params;
  final List<VariableObject> _states;
  final List<DatasetObject> _dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: _node,
      forPlay: _forPlay,
      child: Row(
        mainAxisAlignment: _mainAxisAlignment.get,
        crossAxisAlignment: _crossAxisAlignment.get,
        mainAxisSize: _mainAxisSize.get,
        children: _children.isNotEmpty
            ? _children
                .map(
                  (final e) => e.toWidget(
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
