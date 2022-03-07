/*import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_editor/src/cubits/google_fonts/cubit.dart';
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/design_system/textfield/minitextfield.dart';
import 'package:mobile_editor/src/elements/features/menu_voice.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';

//ignore: must_be_immutable
class BottomBarItemControls extends StatefulWidget {
  CNode node;
  Function(String, String) callBack;
  BottomBarItemControls({
    Key? key,
    required this.node,
    required this.callBack,
  }) : super(key: key);

  @override
  _BottomBarItemControlsState createState() => _BottomBarItemControlsState();
}

class _BottomBarItemControlsState extends State<BottomBarItemControls> {
  double? height;
  String? iconState;
  String? labelState;

  @override
  void initState() {
    super.initState();
    iconState = widget.node.icon;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () => showPicker(),
        child: HoverWidget(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.transparent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        MdiIcons.fromString(iconState!),
                        color: Colors.white,
                      ),
                    ),
                    CText(
                      '${widget.item.label}',
                      color: Palette.white,
                      size: 11,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                cancelButton(),
              ],
            ),
          ),
          hoverChild: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 1, style: BorderStyle.solid, color: Colors.white),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        MdiIcons.fromString(iconState!),
                        color: Colors.white,
                      ),
                    ),
                    CText(
                      '${widget.item.label}',
                      color: Palette.white,
                      size: 11,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                cancelButton(),
              ],
            ),
          ),
          onHover: (e) {},
        ));
  }

  Widget cancelButton() {
    return widget.canDelete
        ? GestureDetector(
            onTap: () => widget.onCancel(true, widget.item),
            child: HoverWidget(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  MdiIcons.minus,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              hoverChild: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFFF5B5B),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  MdiIcons.minus,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              onHover: (e) {},
            ),
          )
        : const SizedBox();
  }

  showPicker() {
    var icons = iconMap.keys.map((key) => IconDefinition(key));
    TextEditingController editingController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    List<IconDefinition> filteredIcons = [];
    showDialog<void>(
      context: context,
      builder: (context) {
        GoogleFontsCubit cubit = GoogleFontsCubit();
        return BlocProvider<GoogleFontsCubit>(
          create: (context) => cubit,
          child: AlertDialog(
            title: const CText('Edit Tab'),
            content: BlocBuilder<GoogleFontsCubit, String>(
              bloc: cubit,
              builder: (context, state) {
                return Container(
                  height: 520,
                  width: (400),
                  child: Column(
                    children: [
                      CText(
                        'Change label',
                        color: Palette.white,
                        size: 11,
                        weight: FontWeight.w500,
                      ),
                      CMiniTextField(
                        controller: nameController,
                        placeholder: 'Write here',
                        color: Colors.black,
                        callBack: (text) {
                          setState(() {
                            labelState = text;
                          });
                          final old = MenuVoice.fromJson(widget.item.toJson());
                          widget.item.label = labelState;
                          widget.callBack(widget.item, old);
                        },
                      ),
                      CText(
                        'Change icon',
                        color: Palette.white,
                        size: 11,
                        weight: FontWeight.w500,
                      ),
                      CMiniTextField(
                        controller: editingController,
                        placeholder: 'Write here',
                        color: Colors.black,
                        callBack: (text) {
                          cubit.updateTextToFind(text);
                          filteredIcons = icons
                              .where((icon) =>
                                  state.isEmpty ||
                                  icon.title!
                                      .toLowerCase()
                                      .contains(state.toLowerCase()))
                              .toList();
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.black12,
                      ),
                      Container(
                        height: 326,
                        child: GridView.builder(
                          itemCount: filteredIcons.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                          ),
                          itemBuilder: (context, index) {
                            final icon = filteredIcons[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconState = icon.title;
                                });
                                final old =
                                    MenuVoice.fromJson(widget.item.toJson());
                                widget.item.icon = icon.title;
                                widget.item.label = labelState;
                                widget.callBack(widget.item, old);
                                Navigator.of(context, rootNavigator: true).pop(null);
                              },
                              child: new Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: new SizedBox.expand(
                                  child: new Hero(
                                    tag: icon,
                                    child: new Icon(
                                      icon.iconData,
                                      size: 32.0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  //setState(() => fill = pickerColor);
                  Navigator.of(context, rootNavigator: true).pop(null);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

MdiIcons iconLib = new MdiIcons();

class IconDefinition implements Comparable {
  IconData? iconData;
  String? title;

  IconDefinition(String key) {
    this.iconData = iconLib[key];
    this.title = this.toKebabCase(key);
  }

  String toKebabCase(String str) {
    return str
        .replaceAllMapped(
            RegExp(
                r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
            (Match m) => "${m[0]!.toLowerCase()}_")
        .split(RegExp(r'(_|\s)+'))
        .takeWhile((value) => value != '')
        .join('-');
  }

  @override
  String toString() => 'IconDefinition{iconData: $iconData, title: $title}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconDefinition &&
          runtimeType == other.runtimeType &&
          iconData == other.iconData &&
          title == other.title;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode;

  @override
  int compareTo(other) => title!.compareTo(other.title);
}*/
