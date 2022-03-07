// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/src/design_system/text.dart';

/// It displays the name of a CNode
/// ATTENTION: Use this only inside a ChildConditionBuilder
/// /builder/child_condition.dart
class PlaceholderChildBuilder extends StatelessWidget {
  /// Constructor
  const PlaceholderChildBuilder({
    required this.name,
    Key? key,
  }) : super(key: key);

  /// Name of the node
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CText(
        name,
        size: 16,
        customColor: Colors.white,
      ),
    );
  }
}
