// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/src/services/node_service.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_widgets/src/elements/index.dart';

/// It displays the name of a CNode
/// ATTENTION: Use this only inside a ChildConditionBuilder
/// /builder/child_condition.dart
class PlaceholderChildBuilder extends StatefulWidget {
  /// Constructor
  const PlaceholderChildBuilder({
    required this.name,
    required this.node,
    required this.forPlay,
    final Key? key,
  }) : super(key: key);

  /// Name of the node
  final String name;
  final CNode node;
  final bool forPlay;

  @override
  State<PlaceholderChildBuilder> createState() =>
      _PlaceholderChildBuilderState();
}

class _PlaceholderChildBuilderState extends State<PlaceholderChildBuilder> {
  bool isDragging = false;

  @override
  Widget build(final BuildContext context) {
    if (widget.forPlay) return const SizedBox();
    return DragTarget<DragTargetModel>(
      onAccept: (final data) async {
        setState(() {
          isDragging = true;
        });
        await sl.get<NodeService>().add(
              dragTarget: data,
              parent: widget.node,
              context: context,
              customIndex: null,
            );
      },
      onMove: (final details) {
        setState(() {
          isDragging = true;
        });
      },
      onLeave: (final details) {
        setState(() {
          isDragging = false;
        });
      },
      builder: (final context, final candidateData, final rejectedData) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<FocusBloc>(context).add(
              OnFocus(
                node: widget.node,
              ),
            );
          },
          child: TContainer(
            padding: EI.smA,
            decoration: BoxDecoration(
              color: isDragging
                  ? primaryColor.withOpacity(0.3)
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FeatherIcons.plusSquare,
                  size: 24,
                  color: Colors.grey,
                ),
                const Gap(Grid.small),
                THeadline3(
                  'Drop in ${widget.name}',
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
