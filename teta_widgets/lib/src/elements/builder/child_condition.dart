// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/builder/placeholder_child.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Builder
class ChildConditionBuilder extends StatelessWidget {
  /// Returns the [child] widget or a placeholder with the name of the widget
  const ChildConditionBuilder(
    Key? key, {
    required this.name,
    required this.child,
    required this.params,
    required this.states,
    required this.dataset,
    required this.forPlay,
    required this.loop,
  }) : super(key: key);

  /// The CNode's name
  final String name;

  /// The optional child
  final CNode? child;

  /// Params
  final List<VariableObject> params;

  /// States
  final List<VariableObject> states;

  /// Dataset
  final List<DatasetObject> dataset;

  /// ForPlay
  final bool forPlay;

  /// Loop
  final int? loop;

  @override
  Widget build(BuildContext context) {
    return (child != null)
        ? child!.toWidget(
            loop: loop,
            forPlay: forPlay,
            params: params,
            states: states,
            dataset: dataset,
          )
        : !forPlay
            ? PlaceholderChildBuilder(name: name)
            : const SizedBox();
  }
}
