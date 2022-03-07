// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WListTile extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WListTile(
    Key? key, {
    required this.node,
    required this.value,
    required this.isThreeLine,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput value;
  final bool isThreeLine;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: ListTile(
        title: const Text(''),
        isThreeLine: isThreeLine,
        leading: children.isNotEmpty
            ? children[0].toWidget(
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              )
            : null,
        trailing: children.length >= 3
            ? children[2].toWidget(
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              )
            : null,
      ),
    );
  }
}
