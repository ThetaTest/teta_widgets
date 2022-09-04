// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextStylesControl extends StatefulWidget {
  const TextStylesControl({
    required this.node,
    required this.textStyle,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
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
            const THeadline3(
              'Styles',
              color: Colors.white,
            ),
            Row(
              children: [
                if (widget.textStyle.textStyleModel == null)
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
                BounceSmall(
                  onTap: () {
                    if (widget.textStyle.textStyleModel == null) {
                      /*newTextStylePicker(
                          context, BlocProvider.of<TextStylesBloc>(context));*/
                      BlocProvider.of<PanelsBloc>(context)
                          .add(const ChangeIndex(type: PanelsEnum.assets));
                    } else {
                      final old = widget.textStyle.textStyleModel;
                      //String txtSM = widget.node.textStyleModel;
                      //txtSM = null;
                      widget.callBack(null, false, old);
                    }
                  },
                  child: HoverWidget(
                    hoverChild: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Icon(
                        (widget.textStyle.textStyleModel == null)
                            ? Icons.add
                            : Icons.remove,
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
                      child: Icon(
                        (widget.textStyle.textStyleModel == null)
                            ? Icons.add
                            : Icons.remove,
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
        if (widget.textStyle.textStyleModel != null)
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

    showDialog<void>(
      context: context,
      builder: (final context) {
        var searchedText = '';
        return StatefulBuilder(
          builder: (final context, final setState) =>
              BlocProvider<DeviceModeCubit>(
            create: (final BuildContext context) => DeviceModeCubit(),
            child: AlertDialog(
              backgroundColor: const Color(0xFF222222),
              title: const TAlertTitle(
                'Text Styles',
                color: Colors.white,
              ),
              content: SizedBox(
                height: 400,
                width: 300,
                child: Column(
                  children: [
                    CMiniTextField(
                      controller: editingController,
                      placeholder: 'write here',
                      callBack: (final text) => setState(() {
                        searchedText = text;
                      }),
                    ),
                    SizedBox(
                      height: 326,
                      child: BlocBuilder<TextStylesCubit, List<TextStyleModel>>(
                        bloc: textStylesBloc,
                        builder: (final context, final state) {
                          return ListView(
                            shrinkWrap: true,
                            children: state.map((final entry) {
                              if (entry.name!.contains(searchedText)) {
                                return GestureDetector(
                                  onTap: () {
                                    updateTextStyleModel(
                                      entry.name!,
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
                                        entry.name!,
                                        style: GoogleFonts.getFont(
                                          entry.fontFamily!,
                                          fontSize: entry.fontSize!.get(),
                                          fontWeight: entry.fontWeight!.get,
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
              ),
              actions: <Widget>[
                CButton(
                  label: 'Cancel',
                  callback: () => Navigator.of(context).pop(),
                  maxWidth: 60,
                  isPrimary: false,
                ),
              ],
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
          create: (final BuildContext context) => DeviceModeCubit(),
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
          create: (final BuildContext context) => DeviceModeCubit(),
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
