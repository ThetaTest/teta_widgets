// Dart imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/blocs/panels/index.dart';
import 'package:teta_core/src/blocs/text_styles/index.dart';
import 'package:teta_core/src/cubits/device_mode/cubit.dart';
import 'package:teta_core/src/design_system/buttons/button.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/models/text_style.dart';

// Project imports:
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextStylesControl extends StatefulWidget {
  const TextStylesControl({
    required this.node,
    required this.textStyle,
    required this.callBack,
    Key? key,
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
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CText(
              'Styles',
              color: Palette.white,
              size: 16,
              weight: FontWeight.bold,
            ),
            Row(
              children: [
                if (widget.textStyle.textStyleModel == null)
                  GestureDetector(
                    onTap: () => showPicker(
                      context,
                      BlocProvider.of<TextStylesBloc>(context),
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
                      onHover: (e) {},
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
                GestureDetector(
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
                    onHover: (e) {},
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
              showPicker(context, BlocProvider.of<TextStylesBloc>(context));
            },
          ),
      ],
    );
  }

  void updateTextStyleModel(
    String name, {
    required bool flag,
  }) {
    final old = widget.textStyle.textStyleModel;
    widget.callBack(name, flag, old);
    Navigator.of(context, rootNavigator: true).pop(null);
    setState(() {
      textStyleModel = name;
    });
  }

  void showPicker(BuildContext context, TextStylesBloc textStylesBloc) {
    final editingController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) {
        var searchedText = '';
        return StatefulBuilder(
          builder: (context, setState) => BlocProvider<DeviceModeCubit>(
            create: (BuildContext context) => DeviceModeCubit(),
            child: AlertDialog(
              backgroundColor: const Color(0xFF222222),
              title: const CText(
                'Text Styles',
                size: 16,
                weight: FontWeight.bold,
                customColor: Colors.white,
              ),
              content: SizedBox(
                height: 400,
                width: 300,
                child: Column(
                  children: [
                    CMiniTextField(
                      controller: editingController,
                      placeholder: 'write here',
                      color: Colors.white,
                      callBack: (text) => setState(() {
                        searchedText = text;
                      }),
                    ),
                    SizedBox(
                      height: 326,
                      child: BlocBuilder<TextStylesBloc, List<TextStyleModel>>(
                        bloc: textStylesBloc,
                        builder: (context, state) {
                          return ListView(
                            shrinkWrap: true,
                            children: state.map((entry) {
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
                                          fontSize: entry.fontSize!.get,
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

  void newTextStylePicker(BuildContext context, TextStylesBloc textStylesBloc) {
    final editingController = TextEditingController();
    var title = '';
    showDialog<void>(
      context: context,
      builder: (context) {
        return BlocProvider<DeviceModeCubit>(
          create: (BuildContext context) => DeviceModeCubit(),
          child: AlertDialog(
            title: const CText('Create new text style', size: 16),
            content: SizedBox(
              height: 100,
              width: height! - 200,
              child: Column(
                children: [
                  CMiniTextField(
                    controller: editingController,
                    placeholder: 'Text Style',
                    color: Colors.black,
                    callBack: (text) => title = text,
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
                child: const CText('Cancel', size: 12),
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
                  child: const CText('Create', color: Palette.white, size: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void editTextStylePicker(BuildContext context, CNode node, String name) {
    final editingController = TextEditingController();
    var title = '';
    showDialog<void>(
      context: context,
      builder: (context) {
        return BlocProvider<DeviceModeCubit>(
          create: (BuildContext context) => DeviceModeCubit(),
          child: AlertDialog(
            title: CText('Edit $name', size: 16),
            content: SizedBox(
              height: 100,
              width: height! - 200,
              child: Column(
                children: [
                  CMiniTextField(
                    controller: editingController,
                    placeholder: 'Text Style',
                    color: Colors.black,
                    callBack: (text) => title = text,
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
                child: const CText('Cancel', size: 12),
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
                  child: const CText('Create', color: Palette.white, size: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}