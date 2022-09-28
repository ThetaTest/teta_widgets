// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

/// It displays the name of a CNode
/// ATTENTION: Use this only inside a ChildConditionBuilder
/// /builder/child_condition.dart
class PlaceholderChildBuilder extends StatelessWidget {
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
  Widget build(final BuildContext context) {
    return BlocBuilder<AddInFlagCubit, bool>(
      builder: (final context, final state) {
        if (forPlay) return const SizedBox();
        //if (!state) return THeadline3(name);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: BounceLarge(
            onTap: () {
              final prj = (BlocProvider.of<FocusProjectBloc>(context).state
                      as ProjectLoaded)
                  .prj;
              final focusPageBloc = BlocProvider.of<PageCubit>(context);
              final refreshCubit = BlocProvider.of<RefreshCubit>(context);
              final focusBloc = BlocProvider.of<FocusBloc>(context);
              showDialog<void>(
                context: context,
                builder: (final c) => BlocProvider.value(
                  value: refreshCubit,
                  child: BlocProvider.value(
                    value: focusPageBloc,
                    child: BlocProvider.value(
                      value: focusBloc,
                      child: WidgetDialogDialog(
                        node: node,
                        prj: prj,
                        page: focusPageBloc.state,
                        forNewNode: true,
                        betweenNodes: false,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: HoverWidget(
              onHover: (final e) {},
              hoverChild: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Palette.blue.withOpacity(0.5),
                  borderRadius: BR(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FeatherIcons.plus,
                        color: Colors.white,
                      ),
                      const Gap(Grid.small),
                      THeadline3(
                        BlocProvider.of<PageCubit>(context).state.isPage
                            ? 'Add in $name'
                            : 'Add in ${name.contains('Page') ? name.replaceFirst('Page', 'Component') : name}',
                      ),
                    ],
                  ),
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Palette.blue.withOpacity(0.2),
                  borderRadius: BR(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FeatherIcons.plus,
                        color: Colors.white,
                      ),
                      const Gap(Grid.small),
                      THeadline3(
                        BlocProvider.of<PageCubit>(context).state.isPage
                            ? 'Add in $name'
                            : 'Add in ${name.contains('Page') ? name.replaceFirst('Page', 'Component') : name}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
