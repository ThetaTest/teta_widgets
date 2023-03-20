// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import '../../../../teta_widgets.dart';
import 'package:teta_front_end/teta_front_end.dart';

class MainAxisAlignmentControls extends StatefulWidget {
  const MainAxisAlignmentControls({
    required this.mainAxisAlignment,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FMainAxisAlignment mainAxisAlignment;
  final Function(FMainAxisAlignment, FMainAxisAlignment) callBack;

  @override
  MainAxisAlignmentControlsState createState() =>
      MainAxisAlignmentControlsState();
}

class MainAxisAlignmentControlsState extends State<MainAxisAlignmentControls> {
  String? dropdown;

  @override
  void initState() {
    super.initState();
    dropdown = widget.mainAxisAlignment.getString;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          setState(() {
            dropdown = widget.mainAxisAlignment.getString;
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
                      'Main axis alignment',
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
                height: node.globalType == NType.column ? 150 : null,
                padding: EI.smA,
                child: Center(
                  child: node.globalType == NType.row
                      ? Row(
                          mainAxisAlignment: widget.mainAxisAlignment.get,
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
                          mainAxisAlignment: widget.mainAxisAlignment.get,
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
                      final old = FMainAxisAlignment()
                          .fromJson(widget.mainAxisAlignment.toJson());
                      final mAA = widget.mainAxisAlignment..set('Start');
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
                      final old = FMainAxisAlignment()
                          .fromJson(widget.mainAxisAlignment.toJson());
                      final mAA = widget.mainAxisAlignment..set('Center');
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
                      final old = FMainAxisAlignment()
                          .fromJson(widget.mainAxisAlignment.toJson());
                      final mAA = widget.mainAxisAlignment..set('End');
                      widget.callBack(mAA, old);
                    },
                  ),
                  const Gap(4),
                  AlignmentButton(
                    iconPath:
                        'assets/icons/controls/space-around-alignment.png',
                    value: 'Space Around',
                    selectedValue: dropdown ?? 'Start',
                    callback: () {
                      setState(() {
                        dropdown = 'Space Around';
                      });
                      final old = FMainAxisAlignment()
                          .fromJson(widget.mainAxisAlignment.toJson());
                      final mAA = widget.mainAxisAlignment..set('Space Around');
                      widget.callBack(mAA, old);
                    },
                  ),
                  const Gap(4),
                  AlignmentButton(
                    iconPath:
                        'assets/icons/controls/space-between-alignment.png',
                    value: 'Space Between',
                    selectedValue: dropdown ?? 'Start',
                    callback: () {
                      setState(() {
                        dropdown = 'Space Between';
                      });
                      final old = FMainAxisAlignment()
                          .fromJson(widget.mainAxisAlignment.toJson());
                      final mAA = widget.mainAxisAlignment
                        ..set('Space Between');
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

class AlignmentButton extends StatelessWidget {
  const AlignmentButton({
    super.key,
    required this.iconPath,
    required this.value,
    required this.selectedValue,
    required this.callback,
    this.icon,
  });

  final String iconPath;
  final IconData? icon;
  final String value;
  final String selectedValue;
  final Function() callback;

  @override
  Widget build(final BuildContext context) {
    return BounceSmall(
      key: ValueKey(
        'AlignmentButton value: $value selectedValue: $selectedValue',
      ),
      onTap: callback,
      child: HoverWidget(
        onHover: (final e) {},
        hoverChild: TContainer(
          width: 32,
          height: 32,
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            color: Palette.txtPrimary,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: TContainer(
            decoration: const BoxDecoration(
              color: Palette.bgPrimary,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Center(
              child: icon != null
                  ? Icon(
                      icon,
                      size: 20,
                      color: Palette.txtPrimary,
                    )
                  : Image.asset(iconPath, width: 24, height: 24),
            ),
          ),
        ),
        child: TContainer(
          width: 32,
          height: 32,
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            gradient: value == selectedValue
                ? const LinearGradient(
                    colors: [Palette.yellow, Palette.magenta],
                  )
                : null,
            color: value == selectedValue
                ? null
                : Palette.txtPrimary.withOpacity(0.3),
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: TContainer(
            decoration: const BoxDecoration(
              color: Palette.bgPrimary,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Center(
              child: icon != null
                  ? Icon(
                      icon,
                      size: 20,
                      color: Palette.txtPrimary,
                    )
                  : Image.asset(iconPath, width: 24, height: 24),
            ),
          ),
        ),
      ),
    );
  }
}
