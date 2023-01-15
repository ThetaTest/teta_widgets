// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/teta_repositories.dart';
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
    return DragTarget<DragTargetObject>(
      onAccept: (final data) async {
        setState(() {
          isDragging = true;
        });

        await sl.get<NodeRepository>().addNodeWithCustomIndex(
              node: data.node!,
              parent: widget.node,
              index: 0,
              pageId: BlocProvider.of<PageCubit>(context).state.id,
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
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<FocusBloc>(context).add(
                OnFocus(
                  node: widget.node,
                ),
              );
            },
            child: TContainer(
              width: double.infinity,
              padding: EI.smA,
              decoration: BoxDecoration(
                color: isDragging
                    ? primaryColor.withOpacity(0.3)
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: THeadline3(
                  'Add in ${widget.name}',
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
