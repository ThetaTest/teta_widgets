// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_front_end/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class TextStylesControl extends StatefulWidget {
  const TextStylesControl({
    required this.textStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextStyle textStyle;
  final Function(String?, bool, String?) callBack;

  @override
  TextStylesControlState createState() => TextStylesControlState();
}

class TextStylesControlState extends State<TextStylesControl> {
  double? height;
  String? textStyleModel;
  String textToFind = '';

  @override
  void initState() {
    textStyleModel = widget.textStyle.textStyleModel;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TParagraph(
              'Styles',
              color: Colors.white,
            ),
            Row(
              children: [
                if (textStyleModel == null)
                  GestureDetector(
                    onTap: () => showPicker(
                      context,
                      BlocProvider.of<TextStylesCubit>(context),
                    ),
                    child: HoverWidget(
                      hoverChild: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: const Icon(
                          Icons.grid_view,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onHover: (final e) {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: const Icon(
                          Icons.grid_view,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (textStyleModel == null)
                  BounceSmall(
                    onTap: () {
                      BlocProvider.of<PanelsCubit>(context)
                          .changePanel(PanelsEnum.assets);
                    },
                    child: HoverWidget(
                      hoverChild: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onHover: (final e) {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else
                  BounceSmall(
                    onTap: () {
                      final old = textStyleModel;
                      //String txtSM = widget.node.textStyleModel;
                      //txtSM = null;
                      widget.callBack(null, false, old);
                      setState(() {
                        textStyleModel = null;
                      });
                    },
                    child: HoverWidget(
                      hoverChild: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      onHover: (final e) {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        if (textStyleModel != null)
          CButton(
            label: textStyleModel,
            callback: () {
              showPicker(context, BlocProvider.of<TextStylesCubit>(context));
            },
          ),
      ],
    );
  }

  void updateTextStyleModel(
    final String name, {
    required final bool flag,
  }) {
    final old = widget.textStyle.textStyleModel;
    widget.callBack(name, flag, old);
    Navigator.of(context, rootNavigator: true).pop(null);
    setState(() {
      textStyleModel = name;
    });
  }

  void showPicker(
    final BuildContext context,
    final TextStylesCubit textStylesBloc,
  ) {
    final editingController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Palette.bgDialog,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Grid.medium),
          topRight: Radius.circular(Grid.medium),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(
        maxWidth: 600,
        maxHeight: MediaQuery.of(context).size.height / 6 * 5,
      ),
      isScrollControlled: true,
      builder: (final context) {
        var searchedText = '';
        return Padding(
          padding: EI.mdA,
          child: StatefulBuilder(
            builder: (final context, final setState) =>
                BlocProvider<DeviceModeCubit>(
              create: (final BuildContext _) => DeviceModeCubit(context),
              child: Column(
                children: [
                  const THeadline1(
                    'Text Styles',
                    color: Colors.white,
                  ),
                  const Gap(Grid.medium),
                  Column(
                    children: [
                      CMiniTextField(
                        controller: editingController,
                        placeholder: 'Search by name',
                        callBack: (final text) => setState(() {
                          searchedText = text;
                        }),
                      ),
                      SizedBox(
                        height: 326,
                        child:
                            BlocBuilder<TextStylesCubit, List<TextStyleModel>>(
                          bloc: textStylesBloc,
                          builder: (final context, final state) {
                            return ListView(
                              shrinkWrap: true,
                              children: state.map((final entry) {
                                if (entry.name.contains(searchedText)) {
                                  return GestureDetector(
                                    onTap: () {
                                      updateTextStyleModel(
                                        entry.name,
                                        flag: false,
                                      );
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          entry.name,
                                          style: GoogleFonts.getFont(
                                            entry.fontFamily,
                                            fontSize: entry.fontSize.get(
                                              context,
                                              forPlay: false,
                                            ),
                                            fontWeight: entry.fontWeight.get,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void newTextStylePicker(
    final BuildContext context,
    final TextStylesCubit textStylesBloc,
  ) {
    final editingController = TextEditingController();
    var title = '';
    showDialog<void>(
      context: context,
      builder: (final context) {
        return BlocProvider<DeviceModeCubit>(
          create: (final BuildContext _) => DeviceModeCubit(context),
          child: AlertDialog(
            title: const TAlertTitle(
              'Create new text style',
            ),
            content: SizedBox(
              height: 100,
              width: height! - 200,
              child: Column(
                children: [
                  CMiniTextField(
                    controller: editingController,
                    placeholder: 'Text Style',
                    color: Colors.black,
                    callBack: (final text) => title = text,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  //setState(() => fill = pickerColor);
                  Navigator.of(context, rootNavigator: true).pop(null);
                },
                child: const TActionLabel(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  //setState(() => fill = pickerColor);
                  updateTextStyleModel(title, flag: true);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3285FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TActionLabel(
                    'Create',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void editTextStylePicker(
    final BuildContext context,
    final CNode node,
    final String name,
  ) {
    final editingController = TextEditingController();
    var title = '';
    showDialog<void>(
      context: context,
      builder: (final context) {
        return BlocProvider<DeviceModeCubit>(
          create: (final BuildContext _) => DeviceModeCubit(context),
          child: AlertDialog(
            title: TAlertTitle(
              'Edit $name',
            ),
            content: SizedBox(
              height: 100,
              width: height! - 200,
              child: Column(
                children: [
                  CMiniTextField(
                    controller: editingController,
                    placeholder: 'Text Style',
                    color: Colors.black,
                    callBack: (final text) => title = text,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  //setState(() => fill = pickerColor);
                  Navigator.of(context, rootNavigator: true).pop(null);
                },
                child: const TActionLabel(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  //setState(() => fill = pickerColor);
                  updateTextStyleModel(title, flag: true);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3285FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TActionLabel(
                    'Create',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
