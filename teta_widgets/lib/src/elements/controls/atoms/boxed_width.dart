// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/main_axis_alignment.dart';
// Project imports:
import 'package:teta_front_end/teta_front_end.dart';

class BoxedWidthControls extends StatefulWidget {
  const BoxedWidthControls({
    required this.isBoxed,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final bool isBoxed;
  final Function(bool, bool) callBack;

  @override
  BoxedWidthControlsState createState() => BoxedWidthControlsState();
}

class BoxedWidthControlsState extends State<BoxedWidthControls> {
  bool? isBoxed;

  @override
  void initState() {
    super.initState();
    isBoxed = widget.isBoxed;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            isBoxed = widget.isBoxed;
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
                      'Width',
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
                height: 150,
                width: double.maxFinite,
                padding: EI.smA,
                child: isBoxed == true
                    ? Center(
                        child: Padding(
                          padding: EI.smA,
                          child: TContainer(
                            width: 100,
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
                              child: TDetailLabel(
                                'Boxed content',
                                isCentered: true,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EI.smA,
                        child: TContainer(
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
                            child: TDetailLabel(
                              'Full width content',
                              isCentered: true,
                            ),
                          ),
                        ),
                      ),
              ),
              const Gap(Grid.small),
              Row(
                children: [
                  AlignmentButton(
                    iconPath: 'assets/icons/controls/boxed-width.png',
                    value: 'true',
                    selectedValue: '$isBoxed',
                    callback: () {
                      widget.callBack(true, isBoxed!);
                      setState(() {
                        isBoxed = true;
                      });
                    },
                  ),
                  const Gap(4),
                  AlignmentButton(
                    iconPath: 'assets/icons/controls/full-width.png',
                    value: 'false',
                    selectedValue: '$isBoxed',
                    callback: () {
                      widget.callBack(false, isBoxed!);
                      setState(() {
                        isBoxed = false;
                      });
                    },
                  ),
                ],
              ),
              const Gap(Grid.small),
              if (isBoxed != null)
                TParagraph(isBoxed == true ? 'Boxed' : 'Full width'),
              const Gap(Grid.small),
            ],
          );
        },
      ),
    );
  }
}
