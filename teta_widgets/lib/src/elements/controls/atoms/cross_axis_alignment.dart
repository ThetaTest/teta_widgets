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
import 'package:teta_widgets/teta_widgets.dart';

class CrossAxisAlignmentControls extends StatefulWidget {
  const CrossAxisAlignmentControls({
    required this.crossAxisAlignment,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FCrossAxisAlignment crossAxisAlignment;
  final Function(FCrossAxisAlignment, FCrossAxisAlignment) callBack;

  @override
  CrossAxisAlignmentControlsState createState() =>
      CrossAxisAlignmentControlsState();
}

class CrossAxisAlignmentControlsState
    extends State<CrossAxisAlignmentControls> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.crossAxisAlignment.getString(context);
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            dropdown = widget.crossAxisAlignment.getString(context);
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
                      'Cross axis alignment',
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
                height: node.globalType == NType.row ? 150 : null,
                width: double.maxFinite,
                padding: EI.smA,
                child: node.globalType == NType.row
                    ? Row(
                        crossAxisAlignment: widget.crossAxisAlignment.get,
                        children: [
                          TContainer(
                            width: 24,
                            height: 24,
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
                            child: const Center(child: TDetailLabel('1')),
                          ),
                          TContainer(
                            width: 24,
                            height: 24,
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
                            child: const Center(child: TDetailLabel('2')),
                          ),
                          TContainer(
                            width: 24,
                            height: 24,
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
                            child: const Center(child: TDetailLabel('3')),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: widget.crossAxisAlignment.get,
                        children: [
                          TContainer(
                            width: 24,
                            height: 24,
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
                            child: const Center(child: TDetailLabel('1')),
                          ),
                          TContainer(
                            width: 24,
                            height: 24,
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
                            child: const Center(child: TDetailLabel('2')),
                          ),
                          TContainer(
                            width: 24,
                            height: 24,
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
                            child: const Center(child: TDetailLabel('3')),
                          ),
                        ],
                      ),
              ),
              const Gap(Grid.small),
              Row(
                children: [
                  AlignmentButton(
                    iconPath: 'assets/icons/controls/start-alignment.png',
                    value: 'Start',
                    selectedValue: dropdown ?? 'Start',
                    callback: () {
                      setState(() {
                        dropdown = 'Start';
                      });
                      final old = FCrossAxisAlignment()
                          .fromJson(widget.crossAxisAlignment.toJson());
                      final mAA = widget.crossAxisAlignment..set('Start');
                      widget.callBack(mAA, old);
                    },
                  ),
                  const Gap(4),
                  AlignmentButton(
                    iconPath: 'assets/icons/controls/center-alignment.png',
                    value: 'Center',
                    selectedValue: dropdown ?? 'Start',
                    callback: () {
                      setState(() {
                        dropdown = 'Center';
                      });
                      final old = FCrossAxisAlignment()
                          .fromJson(widget.crossAxisAlignment.toJson());
                      final mAA = widget.crossAxisAlignment..set('Center');
                      widget.callBack(mAA, old);
                    },
                  ),
                  const Gap(4),
                  AlignmentButton(
                    iconPath: 'assets/icons/controls/end-alignment.png',
                    value: 'End',
                    selectedValue: dropdown ?? 'Start',
                    callback: () {
                      setState(() {
                        dropdown = 'End';
                      });
                      final old = FCrossAxisAlignment()
                          .fromJson(widget.crossAxisAlignment.toJson());
                      final mAA = widget.crossAxisAlignment..set('End');
                      widget.callBack(mAA, old);
                    },
                  ),
                  const Gap(4),
                  AlignmentButton(
                    iconPath: 'assets/icons/controls/stretch-alignment.png',
                    value: 'Stretch',
                    selectedValue: dropdown ?? 'Start',
                    callback: () {
                      setState(() {
                        dropdown = 'Stretch';
                      });
                      final old = FCrossAxisAlignment()
                          .fromJson(widget.crossAxisAlignment.toJson());
                      final mAA = widget.crossAxisAlignment..set('Stretch');
                      widget.callBack(mAA, old);
                    },
                  ),
                ],
              ),
              const Gap(Grid.small),
              if (dropdown != null) TParagraph(dropdown!),
              const Gap(Grid.small),
            ],
          );
        },
      ),
    );
  }
}
