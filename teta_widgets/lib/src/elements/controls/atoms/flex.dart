// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import '../../../../teta_widgets.dart';
import 'main_axis_alignment.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FlexControls extends StatefulWidget {
  const FlexControls({
    required this.isTight,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final bool isTight;
  final Function(bool, bool) callBack;

  @override
  CrossAxisAlignmentControlsState createState() =>
      CrossAxisAlignmentControlsState();
}

class CrossAxisAlignmentControlsState extends State<FlexControls> {
  bool? isTight;

  @override
  void initState() {
    super.initState();
    isTight = widget.isTight;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            isTight = widget.isTight;
          });
        }
      },
      child: BlocBuilder<FocusBloc, List<int>>(
        builder: (final context, final state) {
          final pageState = context.watch<PageCubit>().state;
          if (pageState is! PageLoaded) return const SizedBox();
          final node = pageState.page.flatList
              .firstWhere((final e) => e.nid == state.first);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Row(
                  children: const [
                    TParagraph(
                      'Flex',
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Palette.txtPrimary.withOpacity(0.3),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Grid.small),
                  ),
                ),
                width: double.maxFinite,
                padding: EI.smA,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: isTight == true ? FlexFit.tight : FlexFit.loose,
                      child: TContainer(
                        width: 80,
                        height: 32,
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Palette.txtPrimary.withOpacity(0.3),
                          ),
                          color: Palette.txtPrimary.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: const Center(
                          child: TDetailLabel('Content'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Grid.small),
              Row(
                children: [
                  AlignmentButton(
                    iconPath: '',
                    icon: FeatherIcons.maximize,
                    value: 'true',
                    selectedValue: '$isTight',
                    callback: () {
                      widget.callBack(true, isTight == true);
                      setState(() {
                        isTight = true;
                      });
                    },
                  ),
                  const Gap(4),
                  AlignmentButton(
                    iconPath: '',
                    icon: FeatherIcons.minimize,
                    value: 'false',
                    selectedValue: '$isTight',
                    callback: () {
                      widget.callBack(false, isTight == true);
                      setState(() {
                        isTight = false;
                      });
                    },
                  ),
                ],
              ),
              const Gap(Grid.small),
              if (isTight != null)
                TParagraph(isTight == true ? 'Maximize' : 'Minimize'),
              const Gap(Grid.small),
            ],
          );
        },
      ),
    );
  }
}
